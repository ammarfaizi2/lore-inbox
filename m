Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUHaUAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUHaUAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHaT5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:57:33 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:27788 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S268983AbUHaTv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:51:29 -0400
Subject: New virtual synchrony API for the kernel: was Re: [Openais] New
	API in openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: John Cherry <cherry@osdl.org>
Cc: openais@lists.osdl.org, linux-ha-dev@lists.linux-ha.org,
       linux-cluster@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net>
References: <1093941076.3613.14.camel@persist.az.mvista.com>
	 <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1093981842.3613.42.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 12:50:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,
As it appears the redhat clusters project is interested in a kernel
implementation of cluster messaging, this interface would have to be
available to both the kernel and user applications.  It possible to
provide EVS services to both kernel and user space applications.  There
currently is no kernel implementation of group messaging, though only a
user space interface.  TIPC could probably export this sort of
interface, or openais's gmi could be ported to the kernel.  Then
openais, redhat's cluster technologies, linux ha, or other group
messaging applications (and there are quite a few) could use that
technology and standardize on the EVS API.

It would be useful for linux cluster developers for a common low level
group communication API to be agreed upon by relevant clusters
projects.  Without this approach, we may end up with several systems all
using different cluster communication & membership mechanisms that are
incompatible. 

Thanks
-steve

On Tue, 2004-08-31 at 10:35, John Cherry wrote:
> Steve,
> 
> This sounds like a low level cluster communication service which would
> be potentially leveraged by other services, such as the event service or
> a group messaging service.  Are you envisioning this to be a public
> interface for applications?
> 
> We discussed a low level cluster communication interface at the cluster
> summit.  The rhat/sistina interface would be used by the cluster manager
> (CMAN) and the lock manager (GDLM), but there was no real momentum to
> make this a public application interface.  It would be great if we could
> derive a common cluster communication interface with the rhat/sistina
> project as well as the TIPC project.  What do you think?
> 
> John
> 
> 
> On Tue, 2004-08-31 at 01:31, Steven Dake wrote:
> > Folks
> > 
> > Its with alot of pleasure that I announce a new API that I implemented
> > over the weekend.
> > 
> > The api is called the "EVS" API and is provided by a seperate library
> > libevs.so/.a.  The standard openais executive is used.  There are two
> > test programs testevs and evsbench which demonstrate the API.  evsbench
> > will benchmark throughput rates.  I get about 9MB/sec on my hardware,
> > however, flow control in the group messaging protocol is slowing this
> > down.  I've gotten 10MB/sec with tweaking the algorithm some.
> > 
> > The API name EVS means "Extended Virtual Syncrhony".  This API provides
> > EVS semantics for those that require the guarantees provided in the face
> > of partitions and merges.
> > 
> > The API provides the following
> > multiple instances may exist at one time
> > group keys of 32 bytes
> > an instance may join one or more groups at one time
> > an instance may leave one or more groups at one time
> > an instance may multicast to the currently joined groups
> > an instance may multicast to unjoined groups
> > any message for a joined group will be delivered via callback
> > configuration changes are delivered via callback
> > 
> > Your comments welcome
> > 
> > Thanks
> > -steve
> > 
> > 
> > ______________________________________________________________________
> > _______________________________________________
> > Openais mailing list
> > Openais@lists.osdl.org
> > http://lists.osdl.org/mailman/listinfo/openais
> 


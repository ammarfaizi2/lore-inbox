Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752921AbWKCB36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbWKCB36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbWKCB36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:29:58 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:65240 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1752926AbWKCB35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:29:57 -0500
Date: Thu, 2 Nov 2006 17:29:40 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Pavel Emelianov <xemul@openvz.org>
cc: Matt Helsley <matthltc@us.ibm.com>, vatsa@in.ibm.com, balbir@in.ibm.com,
       Paul Menage <menage@google.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
In-Reply-To: <4549ECF8.2070508@openvz.org>
Message-ID: <Pine.LNX.4.64N.0611021717570.12501@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com>  <45486925.4000201@openvz.org>
  <20061101181236.GC22976@in.ibm.com>  <1162419565.12419.154.camel@localhost.localdomain>
  <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com> 
 <4549B5A3.2010908@openvz.org> <1162466807.12419.194.camel@localhost.localdomain>
 <4549ECF8.2070508@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Pavel Emelianov wrote:

> >> Beancounter may have more than 409 tasks, while configfs
> >> doesn't allow attributes to store more than PAGE_SIZE bytes
> >> on read. So how would you fill so many tasks in one page?
> > 
> > 	To be clear that's a limitation of configfs as an interface. In the
> > Resource Groups code, for example, there is no hard limitation on length
> > of the underlying list. This is why we're talking about a filesystem
> > interface and not necessarily a configfs interface.
> 
> David Rientjes persuaded me that writing our own file system is
> reimplementing the existing thing. If we've agreed with file system
> interface then configfs may be used. But the limitations I've
> pointed out must be discussed.
> 

What are we really discussing here?  The original issue that you raised 
with the infrastructure was an fs vs. syscall interface and I simply 
argued in favor of an fs-based approach because containers are inherently 
hierarchial.  As Paul Jackson mentioned, this is one of the advantages 
that cpusets has had since its inclusion in the kernel and the abstraction 
of cpusets from containers makes a convincing case for how beneficial it 
has been and will continue to be.

Regardless of whether configfs is specifically used for this particular 
purpose is irrelevant in deciding fs vs syscall.  Certainly it could be 
used for lightweight purposes but it by no means is the only possibility 
for containers.  I have observed no further advocation for a syscall 
interface; it seems like a no-brainer that if there are certain 
limitations on configfs that you have pointed out that would be 
disadvantageous to containers that another fs implementation would 
suffice.

> Let me remind:
> 1. limitation of size of data written out of configfs;
> 2. when configfs is a module user won't be able to
>    use beancounters.
> 
> and one new
> 3. now in beancounters we have /proc/user_beancounters
>    file that shows the complete statistics on BC. This
>    includes all then beancounters in the system with all
>    resources' held/maxheld/failcounters/etc. This is very
>    handy and "vividly": a simple 'cat' shows you all you
>    need. With configfs we lack this very handy feature.
> 

Ok, so each of these issues includes a specific criticism against configfs 
for containers.  So a different fs-based interface similiar to the cpuset 
abstraction from containers is certainly appropriate.

		David

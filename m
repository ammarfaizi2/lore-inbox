Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVGVDW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVGVDW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGVDW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:22:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45744 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262012AbVGVDWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:22:25 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: linux-cluster@redhat.com
Subject: Re: [Linux-cluster] Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Date: Fri, 22 Jul 2005 13:22:15 +1000
User-Agent: KMail/1.7.2
Cc: "Walker, Bruce J (HP-Labs)" <bruce.walker@hp.com>,
       "David Teigland" <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, clusters_sig@lists.osdl.org
References: <3689AF909D816446BA505D21F1461AE404167CFB@cacexc04.americas.cpqcorp.net>
In-Reply-To: <3689AF909D816446BA505D21F1461AE404167CFB@cacexc04.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507221322.16706.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 July 2005 02:55, Walker, Bruce J (HP-Labs) wrote:
> Like Lars, I too was under the wrong impression about this configfs
> "nodemanager" kernel component.  Our discussions in the cluster meeting
> Monday and Tuesday were assuming it was a general service that other
> kernel components could/would utilize and possibly also something that
> could send uevents to non-kernel components wanting a std. way to see
> membership information/events.
>
> As to kernel components without corresponding user-level "managers", look
> no farther than OpenSSI.  Our hope was that we could adapt to a user-land
> membership service and this interface thru configfs would drive all our
> kernel subsystems.

Guys, it is absolutely stupid to rely on a virtual filesystem for 
userspace/kernel communication for any events that might have to be 
transmitted inside the block IO path.  This includes, among other things, 
memberhips events.  Inserting a virtual filesystem into this path does 
nothing but add long call chains and new, hard-to-characterize memory 
usage.

There are already tried-and-true interfaces that are designed to do this 
kind of job efficiently and with quantifiable resource requirements: 
sockets (UNIX domain or netlink) and ioctls.  If you want to layer a 
virtual filesystem on top as a user friendly way to present current cluster 
configuration or as a way to provide some administrator knobs, then fine, 
virtual filesystems are good for this kind of thing.  But please do not try 
to insinuate that bloat into the block IO path.

Regards,

Daniel

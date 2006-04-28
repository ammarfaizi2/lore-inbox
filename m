Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWD1B6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWD1B6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWD1B6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:58:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:41159 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964996AbWD1B63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:58:29 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060421191340.0b218c81.akpm@osdl.org>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
	 <1145638722.14804.0.camel@linuxchandra>
	 <20060421155727.4212c41c.akpm@osdl.org>
	 <1145670536.15389.132.camel@linuxchandra>
	 <20060421191340.0b218c81.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 27 Apr 2006 18:58:25 -0700
Message-Id: <1146189505.24650.221.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 19:13 -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > > 
> > > c) pointer to prototype code if poss
> > 
> > Both the memory controllers are fully functional. We need to trim them
> > down.
> > 
> > active/inactive list per class memory controller:
> > http://prdownloads.sourceforge.net/ckrm/mem_rc-f0.4-2615-v2.tz?download
> 
> Oh my gosh.  That converts memory reclaim from per-zone LRU to
> per-CKRM-class LRU.  If configured.
> 
> This is huge.  It means that we have basically two quite different versions
> of memory reclaim to test and maintain.   This is a problem.
> 
> (I hope that's the before-we-added-comments version of the patch btw).
> 
> > pzone based memory controller:
> > http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2
> 
> From a super-quick scan that looks saner.  Is it effective?  Is this the
> way you're planning on proceeding?
> 
> This requirement is basically a glorified RLIMIT_RSS manager, isn't it? 
> Just that it covers a group of mm's and not just the one mm?
> 
> Do you attempt to manage just pagecache?  So if class A tries to read 10GB
> from disk, does that get more aggressively reclaimed based on class A's
> resource limits?
> 
> This all would have been more comfortable if done on top of the 2.4
> kernel's virtual scanner.
> 
> (btw, using the term "class" to identify a group of tasks isn't very
> comfortable - it's an instance, not a class...)
> 
> 
> Worried.

The object of this infrastructure is to get a unified interface for
resource management, irrespective of the resource that is being managed.

As I mentioned in my earlier email, subsystem experts are the ones who
will finally decide what type resource controller they will accept. With
VM experts' direction and advice, i am positive that we will get an
excellent memory controller (as well as other controllers).

As you might have noticed, we have gone through major changes to come to
community's acceptance levels. We are now making use of all possible
features (kref, process event connector, configfs, module parameter,
kzalloc) in this infrastructure.

Having a CPU controller, two memory controllers, an I/O controller and a
numtasks controller proves that the infrastructure does handle major
resources nicely and is also capable of managing virtual resources.

Hope i reduced your worries (at least some :).

regards,

chandra
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



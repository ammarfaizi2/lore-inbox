Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWD1Xnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWD1Xnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWD1Xnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:43:33 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4556 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964998AbWD1Xnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:43:32 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, ashok.raj@intel.com,
       Alan Stern <stern@rowland.harvard.edu>, herbert@13thfloor.at,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com
In-Reply-To: <20060428162302.79926325.akpm@osdl.org>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
	 <1146075534.24650.11.camel@linuxchandra>
	 <20060426114348.51e8e978.akpm@osdl.org>
	 <20060426122926.A31482@unix-os.sc.intel.com>
	 <1146082893.24650.27.camel@linuxchandra>
	 <20060426132644.A31761@unix-os.sc.intel.com>
	 <1146265920.7063.133.camel@linuxchandra>
	 <20060428162302.79926325.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 28 Apr 2006 16:43:29 -0700
Message-Id: <1146267809.7063.141.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 16:23 -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > Looks like the patches I provided is a step backward from where Ashok &
> > Andrew were taking the register_cpu_notifier stuff to.
> > 
> > After some discussions with Ashok we both think the following would be
> > the right direction:
> > 	1 revert the changes i pushed recently
> > 	2 make all usages of register_cpu_notifier to be _init and 
> >           __initdata (if hotplug cpu is defined these are removed)
> > 	3 export the symbols register_cpu_notifier and
> >           unregister_cpu_notifier only in CONFIG_HOTPLUG_CPU is defined
> > 	4 move the hot plug cpu based usages of register_cpu_notifier
> > 	  inside #ifdef CONFIG_HOTPLUF_CPU(like xfs's usage).
> > 
> > I have few questions:
> >  - any problems with the above direction (mainly 3) ?
> >  - Should we proceed in this direction ?
> >  - is it too late for 2.6.17 ? if not late how much time do we have ?
> 
> hm.  I'm leaning more towards doing something expedient and obvious for
> 2.6.17.  It's pretty late in the cycle, and the only downside is the loss
> of a kbyte or two.  Plus I'll be at linuxtag next week and won't be around to
> help out.
> 
> So if it's OK, can we do something minimal, revisit it after 2.6.17?

- if we are ok with a loss of a kbyte or two, 2.6.17 is fine as is 
  (with my incorrect patches in).
- if we want to save that memory, we can revert the two patches and fix
  xfs to make the register calls only when hotplug cpu is defined. This
  change is also minimal. It is a step in the right direction.

Only downside i can see in reverting my patch is that if there is any
other modules that are doing the same as what xfs was doing, we might
trip in a similar oops.

chandra
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



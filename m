Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSKEI6A>; Tue, 5 Nov 2002 03:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264831AbSKEI6A>; Tue, 5 Nov 2002 03:58:00 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:48014 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264690AbSKEI55>;
	Tue, 5 Nov 2002 03:57:57 -0500
Date: Tue, 5 Nov 2002 14:35:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       Dave Anderson <anderson@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-general] Re: What's left over.
Message-ID: <20021105143553.A11120@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0211040727330.771-100000@home.transmeta.com> <1036429035.1718.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036429035.1718.99.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 04, 2002 at 04:40:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 04:40:11PM +0000, Alan Cox wrote:
> Let me ask another question here
> 
> Other than "register_reboot_notifier()" and adding a 
> "register_exception_notifier()" chain what else does a dump tool need.
> Register_exception_notifier seems to solve about 90% of the insmod gdb 
> problem space as well ?
> 
> 

I had tried to list these in an earlier mail, added a few more
comments now marked by ">>"

1.Enabling IPI to collect CPU state on all processors in the
  system right when dump is triggered (may not be a normal
  situation, so NMIs where supported are the best option)

  >> set/register_nmi_callback could also help in part (though 
  >> synchronization issues need to be thought through so that
  >> the effect on regular system operation is as low as possible), 
  >> but we also need an interface to generate the NMI ipi when
  >> required, and something that generalises on all architectures.

2.Ability to quiesce (silence) the system before dumping 
  (and if in non-disruptive mode, then restore it back)
 >> smp_call_function may not the ideal option for many situations
 >> - in general we would like to have a separate "force" path
 >> available for some troublesome situations, and it would be 
 >> nice to be able to tackle non-disruptive (but accurate) dumping
 >> as well.

 >> maybe 1 & 2 can be combined in some form
 >> Dump should preferably not overlap with a regularly used IPI.
 
3. Calls into dump from kernel paths (panic, oops, sysrq
   etc). 

   >> This is where your register_xxx_notifier(s) fit in

4. Exports of symbols to help with physical memory 
   traversal and verification

   >> Covers what Andi Kleen referred to as 
   >> iterate_over_memmap_and_give_me_type()
   >> (a way to figure out the type of memory - true ram or other)

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


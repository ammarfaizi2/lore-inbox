Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUD0Ora@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUD0Ora (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUD0Ora
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:47:30 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:12556 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264153AbUD0Or0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:47:26 -0400
Date: Tue, 27 Apr 2004 22:48:23 +0800 (WST)
From: raven@themaw.net
To: Paul Jackson <pj@sgi.com>
cc: Erdi Chen <erdi.chen@digeo.com>, Dave Airlie <airlied@linux.ie>,
       davem@redhat.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
Message-ID: <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net>
References: <20040426204947.797bd7c2.pj@sgi.com>
 <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Ian Kent wrote:

I have to built 2.6.6-rc2-mm2 on my Ultra 1.
I don`t have USB so it's not in my config and the kernel builds OK.
Also I don't have a Creator card.

Unfortuneately I get an oops (see below) when I attempt to start X which 
appears to be the same as with 2.6.6-rc2-mm1. If more info, configs etc. 
would be useful let me know.

> On Mon, 26 Apr 2004, Paul Jackson wrote:
> 
> > Trying to build sparc64 as of 2.6.6-rc2-mm2, using the cross_compile
> > tools from http://developer.osdl.org/dev/plm/cross_compile/ (nice
> > tools - thanks!) fails for two reasons:
> > 
> > 1) Broken drivers/char/drm/ffb_drv.c:
> > 
> >       CC [M]  drivers/char/drm/ffb_drv.o
> >     In file included from drivers/char/drm/ffb_drv.c:336:
> >     drivers/char/drm/drm_drv.h:547: error: `ffb_PCI_IDS' undeclared here (not in a function)
> >     drivers/char/drm/drm_drv.h:547: error: initializer element is not constant
> >     drivers/char/drm/drm_drv.h:547: error: (near initialization for `ffb_pciidlist[0]')
> >     drivers/char/drm/ffb_drv.c:225: warning: `ffb_count_card_instances' defined but not used
> >     make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1
> > 
> >    Andrew already reported this last week - something about missing PCI ID's.
> > 
> 

Dave Airlie suggested I add (to ffb.h):

#define DRIVER_PCI_IDS { 0,0,0 }

for 2.6.6-rc2-mm1.

It appears that for 2.6.6-rc2-mm2 this should be:

#define ffb_PCI_IDS { 0,0,0 }

which allows the kernel to build.

Dave was however, concerned that this may have side effects.

So to the point,

Apr 24 02:05:04 donald Unable to handle kernel paging request at virtual address 0000000040894000
Apr 24 02:05:04 donald tsk->{mm,active_mm}->context = 000000000000059e
Apr 24 02:05:04 donald tsk->{mm,active_mm}->pgd = fffff80032382000
Apr 24 02:05:04 donald \|/ ____ \|/
Apr 24 02:05:04 donald "@'/ .. \`@"
Apr 24 02:05:04 donald /_| \__/ |_\
Apr 24 02:05:04 donald \__U_/
Apr 24 02:05:04 donald X(3403): Oops [#1]
Apr 24 02:05:04 donald TSTATE: 0000004480009607 TPC: 000000000058156c TNPC: 0000000000581570 Y: 00000000    Not tainted
Apr 24 02:05:04 donald TPC: <fb_set_cmap+0x10c/0x140>
Apr 24 02:05:04 donald g0: 0000000000000003 g1: 0000000000000000 g2: 0000000000000000 g3: 0000000000000000
Apr 24 02:05:04 donald g4: fffff80033590b60 g5: 0000000000677640 g6: fffff80033428000 g7: 0000000000000003
Apr 24 02:05:04 donald o0: 0000000000511aa8 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000
Apr 24 02:05:04 donald o4: 000000000000ffff o5: 000000000000004b sp: fffff8003342ad61 ret_pc: 0000000000391ccc
Apr 24 02:05:04 donald RPC: <0x391ccc>
Apr 24 02:05:04 donald l0: 0000000040895ad0 l1: fffff8003342b6da l2: fffff8003342b6dc l3: fffff8003342b6de
Apr 24 02:05:04 donald l4: 0000000000000000 l5: fffff8003342b6e0 l6: 0000000000000000 l7: 000000000000fc00
Apr 24 02:05:04 donald i0: fffff8003342b6e0 i1: 0000000000000000 i2: fffff800007c5400 i3: 0000000000000000
Apr 24 02:05:04 donald i4: 0000000000000010 i5: 0000000000000010 i6: fffff8003342ae21 i7: 0000000000582fe0
Apr 24 02:05:04 donald I7: <sbusfb_ioctl_helper+0x300/0x340>
Apr 24 02:05:04 donald Caller[0000000000582fe0]: sbusfb_ioctl_helper+0x300/0x340
Apr 24 02:05:04 donald Caller[000000000057e434]: fb_ioctl+0x94/0x380
Apr 24 02:05:04 donald Caller[0000000000499258]: sys_ioctl+0x118/0x2e0
Apr 24 02:05:04 donald Caller[0000000000434918]: fbiogetputcmap+0xf8/0x1e0
Apr 24 02:05:04 donald Caller[00000000004b02d8]: compat_sys_ioctl+0xf8/0x280
Apr 24 02:05:04 donald Caller[0000000000410cb4]: linux_sparc_syscall32+0x34/0x40
Apr 24 02:05:04 donald Caller[000000000005abec]: 0x5abec
Apr 24 02:05:04 donald Instruction DUMP: 9815e3ff  02f43fda  97306010 <c2942000> 84100000  83286010  106fffd5  99306010  81cfe008 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUF1TVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUF1TVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUF1TVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:21:52 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:8399 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265138AbUF1TUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:20:51 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.7-mm3: Kernel BUG on dual Opteron with DEBUG_SLAB
Date: Mon, 28 Jun 2004 21:29:35 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040626233105.0c1375b2.akpm@osdl.org> <20040628001935.37b19aa2.akpm@osdl.org> <200406282118.36911.rjwysocki@sisk.pl>
In-Reply-To: <200406282118.36911.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fGH4ACh6QTPTs5u"
Message-Id: <200406282129.35120.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_fGH4ACh6QTPTs5u
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 28 of June 2004 21:18, R. J. Wysocki wrote:
> On Monday 28 of June 2004 09:19, Andrew Morton wrote:
> > "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > >  On Sunday 27 of June 2004 08:31, Andrew Morton wrote:
> > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/
> > >  >2. 6.7-m m3/
> > >
> > >  I see the following: (in the order of importance - to me ;-)):
> > >
> > >  1) Serial console does not work (at all), but earlyprintk _does_
> > > (output goes to tty0 after earlyprintk has finished).
> > >
> > >  Please, fix the serial console ASAP.  It's a pain to hand-rewrite call
> > > traces
> >
> > erk, sorry, I thought the x86_64 console= parsing breakage had been
> > fixed.
> >
> > The below should get you going again while we remember what the problem
> > was.
>
> It's revived the serial console, so thanks a lot!  BTW, can you tell me
> please, what it actually does?  I see that it applies to many
> architectures, not just x86-64 ...

[snip]

> Now, I'm going to set the DEBUG_SLAB and see what happens. ;-)

Well, it's in the attachement.  Enjoy,

rjw

----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
--Boundary-00=_fGH4ACh6QTPTs5u
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.6.7-mm3-crash.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.7-mm3-crash.log"

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
INIT: version 2.85 booting
System Boot Control: Running /etc/init.d/boot
Mounting /proc filesystem                                             done
Mounting sysfs on /sys                                                done
Mounting /dev/pts                                                     done
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mempolicy:585
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80172b26>] <ffffffff80172b26>{zonelist_policy+86}
RSP: 0018:000001003fa7dd50  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000020 RCX: 0000000000000000
RDX: 00000000ffffffff RSI: 000001001ffdb528 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000010 R12: 0000000000000010
R13: 0000000000000040 R14: 000001001ffd3058 R15: 0000000000000020
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a956fa1a0 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff80173207 0000000000000012 000001001ffd3040 000001001ffd3040
       ffffffff80158970 0000000000000016 ffffffff8015d653 0000000000000000
       0000000000000012 0000000000000000
Call Trace:<ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 0f 0b fd 44 34 80 ff ff ff ff 49 02 48 63 d0 48 89 f8 83 e0
RIP <ffffffff80172b26>{zonelist_policy+86} RSP <000001003fa7dd50>
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [2] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7db58  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 000001001ffd3058 R15: 0000000000000020
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000000 000001003fa62370
       000000000000000b ffffffff8013734e ffffffff8010fc93 ffffffff8033d8ef
       0000000000000000 000001003fa7dca8
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff80110595>{die+69} <ffffffff80110db1>{do_invalid_op+145}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80153ca4>{file_read_actor+180}
       <ffffffff8010f039>{error_exit+0} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7db58>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [3] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7d958  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff80110595>{die+69}
       <ffffffff80110db1>{do_invalid_op+145} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80153ca4>{file_read_actor+180} <ffffffff8010f039>{error_exit+0}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80173207>{alloc_pages_current+119}
       <ffffffff80158970>{__get_free_pages+16} <ffffffff8015d653>{kmem_getpages+35}
       <ffffffff8015daaa>{cache_alloc_refill+714} <ffffffff8015dce7>{kmem_cache_alloc+87}
       <ffffffff8013e8ff>{send_signal+95} <ffffffff8013f552>{__group_send_sig_info+178}
       <ffffffff8013f9ef>{do_notify_parent+383} <ffffffff8015ca05>{cache_free_debugcheck+693}
       <ffffffff80137ce5>{do_exit+2741} <ffffffff80137e58>{do_group_exit+232}
       <ffffffff8010e65a>{system_call+126}

Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7d958>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [4] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7d758  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff80110595>{die+69} <ffffffff80110db1>{do_invalid_op+145}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80153ca4>{file_read_actor+180}
       <ffffffff8010f039>{error_exit+0} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7d758>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [5] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7d558  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff80110595>{die+69}
       <ffffffff80110db1>{do_invalid_op+145} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80153ca4>{file_read_actor+180} <ffffffff8010f039>{error_exit+0}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80173207>{alloc_pages_current+119}
       <ffffffff80158970>{__get_free_pages+16} <ffffffff8015d653>{kmem_getpages+35}
       <ffffffff8015daaa>{cache_alloc_refill+714} <ffffffff8015dce7>{kmem_cache_alloc+87}
       <ffffffff8013e8ff>{send_signal+95} <ffffffff8013f552>{__group_send_sig_info+178}
       <ffffffff8013f9ef>{do_notify_parent+383} <ffffffff8015ca05>{cache_free_debugcheck+693}
       <ffffffff80137ce5>{do_exit+2741} <ffffffff80137e58>{do_group_exit+232}
       <ffffffff8010e65a>{system_call+126}

Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7d558>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [6] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7d358  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff80110595>{die+69} <ffffffff80110db1>{do_invalid_op+145}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80153ca4>{file_read_actor+180}
       <ffffffff8010f039>{error_exit+0} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7d358>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [7] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7d158  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff80110595>{die+69}
       <ffffffff80110db1>{do_invalid_op+145} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80153ca4>{file_read_actor+180} <ffffffff8010f039>{error_exit+0}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80173207>{alloc_pages_current+119}
       <ffffffff80158970>{__get_free_pages+16} <ffffffff8015d653>{kmem_getpages+35}
       <ffffffff8015daaa>{cache_alloc_refill+714} <ffffffff8015dce7>{kmem_cache_alloc+87}
       <ffffffff8013e8ff>{send_signal+95} <ffffffff8013f552>{__group_send_sig_info+178}
       <ffffffff8013f9ef>{do_notify_parent+383} <ffffffff8015ca05>{cache_free_debugcheck+693}
       <ffffffff80137ce5>{do_exit+2741} <ffffffff80137e58>{do_group_exit+232}
       <ffffffff8010e65a>{system_call+126}

Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7d158>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [8] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7cf58  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff80110595>{die+69} <ffffffff80110db1>{do_invalid_op+145}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80153ca4>{file_read_actor+180}
       <ffffffff8010f039>{error_exit+0} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7cf58>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [9] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7cd58  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff80110595>{die+69}
       <ffffffff80110db1>{do_invalid_op+145} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80153ca4>{file_read_actor+180} <ffffffff8010f039>{error_exit+0}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80173207>{alloc_pages_current+119}
       <ffffffff80158970>{__get_free_pages+16} <ffffffff8015d653>{kmem_getpages+35}
       <ffffffff8015daaa>{cache_alloc_refill+714} <ffffffff8015dce7>{kmem_cache_alloc+87}
       <ffffffff8013e8ff>{send_signal+95} <ffffffff8013f552>{__group_send_sig_info+178}
       <ffffffff8013f9ef>{do_notify_parent+383} <ffffffff8015ca05>{cache_free_debugcheck+693}
       <ffffffff80137ce5>{do_exit+2741} <ffffffff80137e58>{do_group_exit+232}
       <ffffffff8010e65a>{system_call+126}

Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7cd58>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [10] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7cb58  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff80110595>{die+69} <ffffffff80110db1>{do_invalid_op+145}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80153ca4>{file_read_actor+180}
       <ffffffff8010f039>{error_exit+0} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7cb58>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [11] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7c958  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff80110595>{die+69}
       <ffffffff80110db1>{do_invalid_op+145} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80153ca4>{file_read_actor+180} <ffffffff8010f039>{error_exit+0}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80173207>{alloc_pages_current+119}
       <ffffffff80158970>{__get_free_pages+16} <ffffffff8015d653>{kmem_getpages+35}
       <ffffffff8015daaa>{cache_alloc_refill+714} <ffffffff8015dce7>{kmem_cache_alloc+87}
       <ffffffff8013e8ff>{send_signal+95} <ffffffff8013f552>{__group_send_sig_info+178}
       <ffffffff8013f9ef>{do_notify_parent+383} <ffffffff8015ca05>{cache_free_debugcheck+693}
       <ffffffff80137ce5>{do_exit+2741} <ffffffff80137e58>{do_group_exit+232}
       <ffffffff8010e65a>{system_call+126}

Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7c958>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [12] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7c758  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff80110595>{die+69} <ffffffff80110db1>{do_invalid_op+145}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80153ca4>{file_read_actor+180}
       <ffffffff8010f039>{error_exit+0} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80173207>{alloc_pages_current+119} <ffffffff80158970>{__get_free_pages+16}
       <ffffffff8015d653>{kmem_getpages+35} <ffffffff8015daaa>{cache_alloc_refill+714}
       <ffffffff8015dce7>{kmem_cache_alloc+87} <ffffffff8013e8ff>{send_signal+95}
       <ffffffff8013f552>{__group_send_sig_info+178} <ffffffff8013f9ef>{do_notify_parent+383}
       <ffffffff8015ca05>{cache_free_debugcheck+693} <ffffffff80137ce5>{do_exit+2741}
       <ffffffff80137e58>{do_group_exit+232} <ffffffff8010e65a>{system_call+126}


Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7c758>
CR2: 0000000000000028
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
<ffffffff80132c46>{mm_release+86}
PML4 1fbd6067 PGD 0
Oops: 0000 [13] SMP
CPU 1
Modules linked in:
Pid: 261, comm: logger Not tainted 2.6.7-mm3
RIP: 0010:[<ffffffff80132c46>] <ffffffff80132c46>{mm_release+86}
RSP: 0018:000001003fa7c558  EFLAGS: 00010206
RAX: 000001003fa62370 RBX: 000001003fa62370 RCX: ffffffff803963b8
RDX: ffffffff803963b8 RSI: 0000000000000000 RDI: 0000002a95d33130
RBP: 0000000000000000 R08: 0000000000000040 R09: ffffffff804cc840
R10: 0000000000000000 R11: 0000000000aaaaaa R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 000001003fa62370
FS:  0000002a9588d6e0(0000) GS:ffffffff8049acc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000020a1c000 CR4: 00000000000006e0
Process logger (pid: 261, threadinfo 000001003fa7c000, task 000001003fa62370)
Stack: ffffffff803963b0 0000000000000000 0000000000000028 000001003fa62370
       0000000000000009 ffffffff8013734e ffffffff8010fc93 0000000000000001
       0000000000000028 0000000000000000
Call Trace:<ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff8011f340>{do_page_fault+1200}
       <ffffffff80243ea3>{poke_blanked_console+179} <ffffffff802462a7>{vt_console_print+727}
       <ffffffff80134a7c>{__call_console_drivers+76} <ffffffff8010f039>{error_exit+0}
       <ffffffff80132c46>{mm_release+86} <ffffffff80132c1f>{mm_release+47}
       <ffffffff8013734e>{do_exit+286} <ffffffff8010fc93>{oops_end+35}
       <ffffffff8011f340>{do_page_fault+1200} <ffffffff80243ea3>{poke_blanked_console+179}
       <ffffffff802462a7>{vt_console_print+727} <ffffffff80134a7c>{__call_console_drivers+76}
       <ffffffff8010f039>{error_exit+0} <ffffffff80132c46>{mm_release+86}
       <ffffffff80132c1f>{mm_release+47} <ffffffff8013734e>{do_exit+286}
       <ffffffff8010fc93>{oops_end+35} <ffffffff80110595>{die+69}
       <ffffffff80110db1>{do_invalid_op+145} <ffffffff80172b26>{zonelist_policy+86}
       <ffffffff80153ca4>{file_read_actor+180} <ffffffff8010f039>{error_exit+0}
       <ffffffff80172b26>{zonelist_policy+86} <ffffffff80173207>{alloc_pages_current+119}
       <ffffffff80158970>{__get_free_pages+16} <ffffffff8015d653>{kmem_getpages+35}
       <ffffffff8015daaa>{cache_alloc_refill+714} <ffffffff8015dce7>{kmem_cache_alloc+87}
       <ffffffff8013e8ff>{send_signal+95} <ffffffff8013f552>{__group_send_sig_info+178}
       <ffffffff8013f9ef>{do_notify_parent+383} <ffffffff8015ca05>{cache_free_debugcheck+693}
       <ffffffff80137ce5>{do_exit+2741} <ffffffff80137e58>{do_group_exit+232}
       <ffffffff8010e65a>{system_call+126}

Code: 41 8b 45 28 ff c8 7e 66 48 c7 83 78 02 00 00 00 00 00 00 65
RIP <ffffffff80132c46>{mm_release+86} RSP <000001003fa7c558>
CR2: 0000000000000028
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


--Boundary-00=_fGH4ACh6QTPTs5u--


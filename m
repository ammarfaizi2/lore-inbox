Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWANM5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWANM5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWANM5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:57:17 -0500
Received: from [62.38.115.213] ([62.38.115.213]:45965 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S1751251AbWANM5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:57:15 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Regression in Autofs, 2.6.15-git
Date: Sat, 14 Jan 2006 14:56:53 +0200
User-Agent: KMail/1.9
Cc: hch@lst.de, linux-kernel@vger.kernel.org, raven@themaw.net
References: <200601140217.56724.p_christ@hol.gr> <200601141350.31033.p_christ@hol.gr> <20060114035456.3f50b0d8.akpm@osdl.org>
In-Reply-To: <20060114035456.3f50b0d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XUPyDHkSKZAmhzf"
Message-Id: <200601141456.55530.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XUPyDHkSKZAmhzf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 14 January 2006 1:54 pm, Andrew Morton wrote:
> "P. Christeas" <p_christ@hol.gr> wrote:
> > On Saturday 14 January 2006 1:34 pm, you wrote:
> > > Thanks for working that out.
> > >
> > > It works for me.  Are you able to capture the oops output?
> >
> > Works in what sense? Are you able to reproduce the oops?
>
> No, I am not.  I did `cd /net/<host>/usr/src' and things worked OK.
>
> > It is quite difficult to reproduce the oops, since it makes the whole
> > system freeze (the fs part is oopsed, and then all processes depend on
> > it). Hence I've called it "hard" . It may be captured with a serial
> > console, I 'll give it a try..
>
> OK, thanks.  Also if you're in the console a digital photo of the screen
> works nicely.

Here it is.
(how do I load the symbols into gdb, so that I can see the source listing? 
With vmlinux on i386 it doesn't work.)

My auto.net supplied parameter is:
opts="-fstype=nfs,soft,intr,nodev,nosuid,nonstrict"
I use autofs-4.1.3 and mount-2.12r.
The nfs server is a 2.6.15-rc6.


--Boundary-00=_XUPyDHkSKZAmhzf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="autofs.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="autofs.oops"

Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: nfs autofs4 cpufreq_ondemand cpufreq_userspace cpufreq_powersave p4_clockmod speedstep_lib freq_table nfsd exportfs lockd sunrpc irtty_sir sir_dev irda crc_ccitt rfcomm l2cap bluetooth snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_atiixp snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc i2c_isa 8139too eth1394 sd_mod ohci1394 ieee1394 loop cx88_blackbird cx8802 tda9887 tuner cx8800 cx88xx i2c_algo_bit video_buf ir_common tveeprom i2c_core btcx_risc usb_storage scsi_mod usbhid ehci_hcd ohci_hcd usbcore video container button battery
CPU:    1
EIP:    0060:[<c0162875>]    Not tainted VLI
EFLAGS: 00210202   (2.6.15xrg-gf33dc619) 
EIP is at touch_atime+0x43/0x9f
eax: 40000000   ebx: db67435c   ecx: d8942a00   edx: 00000004
esi: d3aba6c0   edi: d7e942b0   ebp: 00000004   esp: d3cede50
ds: 007b   es: 007b   ss: 0068
Process konqueror (pid: 4751, threadinfo=d3cec000 task=dfda6a90)
Stack: <0>00000001 00000001 d362fd50 d3aba6c0 e1b0e727 00000004 d362fd50 00000000 
       d3aba6c0 d362fd50 00000000 e1b0edd7 00000004 d362fd50 00000002 d371b8bc 
       d362fd50 d362fd50 c1627d40 e1b0e909 d362fd50 d3cedea8 db67435c 00000004 
Call Trace:
 [<e1b0e727>] autofs4_update_usage+0x2c/0x4b [autofs4]
 [<e1b0edd7>] autofs4_revalidate+0x10d/0x121 [autofs4]
 [<e1b0e909>] autofs4_dir_open+0xb7/0x19b [autofs4]
 [<c0158627>] permission+0x7f/0x8c
 [<c0158647>] vfs_permission+0x13/0x17
 [<c0159da5>] may_open+0x53/0x1a1
 [<e1b0e852>] autofs4_dir_open+0x0/0x19b [autofs4]
 [<c014c7cf>] __dentry_open+0xe7/0x1e5
 [<c014c98c>] nameidata_to_filp+0x1f/0x31
 [<c014c8fd>] filp_open+0x30/0x38
 [<c014cb69>] do_sys_open+0x3c/0xaf
 [<c01027cf>] sysenter_past_esp+0x54/0x75
Code: a8 01 75 7e f6 83 78 01 00 00 02 75 75 f6 c4 04 75 70 f6 c4 08 74 10 0f b7 43 28 25 00 f0 00 00 3d 00 40 00 00 74 5b 85 d2 74 1b <8b> 42 2c a8 08 75 50 a8 10 74 10 0f b7 43 28 25 00 f0 00 00 3d 
 <6>note: konqueror[4751] exited with preempt_count 1

--Boundary-00=_XUPyDHkSKZAmhzf--

Return-Path: <linux-kernel-owner+w=401wt.eu-S1752434AbWLVTxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbWLVTxU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWLVTxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:53:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:54927 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbWLVTxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:53:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=V+MhGZI00iwwdFyZOPotc8611nGYzlHOAf7YhUFtnW2Kn6l4lWRbOilCPycUt/Etdxo2UyDDONfcA7Sd2zx33WjpTdvymIZixcBKHOOqF35DQTl7OQn1Rog3by845MfcknzIpKvpcWpnSLUz4bUGY/m/G4bXzgAsgAEpPtS8U2w=
Message-ID: <458C37BE.5000409@gmail.com>
Date: Fri, 22 Dec 2006 20:53:11 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: osv@javad.com
CC: Andrew Morton <akpm@osdl.org>,
       linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com> <87r6urket6.fsf@javad.com>
In-Reply-To: <87r6urket6.fsf@javad.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

osv@javad.com wrote:
> Hi Jiri,
> 
> I've figured out that both old and new mxser drivers have two similar
> problems:
> 
> 1. When there are data coming to a port, sometimes opening of the port
>    entirely locks the box. This is quite reproducible. Any idea what's
>    wrong and how can I help to debug it?

Please enable
* Lock debugging: prove locking correctness
* Lock dependency engine debugging
at Kernel hacking->Kernel debugging

> 2. Another, less important problem, is that if a port is open by some
>    application and I rmmod the mxser (or mxser-new) module, kernel
>    oopses and gets unstable ("xjterm" is the process that keeps the port
>    open):

I'll look into that.

> Couldn't unregister MOXA Smartio/Industio family serial driver
> BUG: unable to handle kernel paging request at virtual address f0fe60be
>  printing eip:
> f0fe60be
> *pde = 3fc04067
> *pte = 00000000
> Oops: 0000 [#1]
> SMP 
> Modules linked in: nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod
> sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel
> snd_hda_codec psmouse i2c_i801 mousedev snd_pcm_oss snd_mixer_oss
> serio_raw i2c_core tsdev 8250_pnp pcspkr parport_pc evdev snd_pcm
> 8250_pci parport snd_timer rtc floppy snd soundcore snd_page_alloc ext3
> jbd mbcache sd_mod usb_storage usbhid ide_cd cdrom uhci_hcd ata_piix
> libata usbcore piix scsi_mod generic ide_core skge thermal processor fan
> CPU:    0
> EIP:    0060:[<f0fe60be>]    Tainted: P      VLI
> EFLAGS: 00210246   (2.6.17-2-686 #1) 
> EIP is at 0xf0fe60be
> eax: ebc8c800   ebx: ebc8c800   ecx: 00000000   edx: efe4e400
> esi: 00000000   edi: e2877a80   ebp: ebc8c80c   esp: d924dbf8
> ds: 007b   es: 007b   ss: 0068
> Process xjterm (pid: 11884, threadinfo=d924c000 task=e6835a90)
> Stack: b01f550c 00123fc3 ebc8c800 b01f5418 e2877a80 b01f170a 00000000 00000000 
>        00000020 e2877a80 d924de98 d924dea8 b0162749 d924dfb0 080e8de0 080e8df8 
>        d924de98 d924de98 00000000 00000003 d924deb0 00000002 00000000 d924de98 
> Call Trace:
>  <b01f550c> normal_poll+0xf4/0x119  <b01f5418> normal_poll+0x0/0x119
>  <b01f170a> tty_poll+0x48/0x60  <b0162749> do_sys_poll+0x1af/0x342
>  <b01631fd> __pollwait+0x0/0xb2  <b0116f2d> default_wake_function+0x0/0xc
>  <b0116f2d> default_wake_function+0x0/0xc  <b0116f2d> default_wake_function+0x0/0xc
>  <b0116f2d> default_wake_function+0x0/0xc  <f182310a> _nv002668rm+0x26/0x2c [nvidia]
>  <b013f030> __alloc_pages+0x4e/0x267  <b0116b0b> activate_task+0x5a/0xa0
>  <b01160df> __activate_task+0x17/0x1d  <b0116f23> try_to_wake_up+0x319/0x323
>  <b0116b0b> activate_task+0x5a/0xa0  <b01160df> __activate_task+0x17/0x1d
>  <b0116f23> try_to_wake_up+0x319/0x323  <b0115f0a> __wake_up_common+0x2f/0x53
>  <b0117cb2> __wake_up+0x2a/0x3d  <b0217309> sock_def_readable+0x31/0x5b
>  <b0267d05> unix_stream_sendmsg+0x200/0x2c4  <b0213924> do_sock_write+0xa3/0xaa
>  <b0213e98> sock_aio_write+0x53/0x61  <b0152afc> do_sync_write+0xb8/0xf3
>  <b012c2a7> autoremove_wake_function+0x0/0x2d  <b026744e> unix_ioctl+0x8b/0x93
>  <b021409a> sock_ioctl+0x193/0x1b5  <b0213f07> sock_ioctl+0x0/0x1b5
>  <b0161e08> do_ioctl+0x1c/0x5d  <b0162093> vfs_ioctl+0x24a/0x25c
>  <b0162920> sys_poll+0x44/0x47  <b0102ae7> sysenter_past_esp+0x54/0x75
> Code:  Bad EIP value.
> EIP: [<f0fe60be>] 0xf0fe60be SS:ESP 0068:d924dbf8
>  
> Note: I'm running Debian kernel 2.6.17.2 but I've seen the same problem
> on 2.6.16.x. Didn't try more recent kernels though. CPU is
> hyper-threaded Pentium-4.

thanks for the report,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

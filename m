Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293236AbSCFFcU>; Wed, 6 Mar 2002 00:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293234AbSCFFcB>; Wed, 6 Mar 2002 00:32:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35747 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293235AbSCFFbz>; Wed, 6 Mar 2002 00:31:55 -0500
Date: Tue, 5 Mar 2002 22:28:43 -0700
Message-Id: <200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <3C84294C.AE1E8CE9@sandino.net>
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net>
	<20020302075847.GE20536@kroah.com>
	<3C84294C.AE1E8CE9@sandino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandino Araico writes:
> Greg KH wrote:
> 
> > On Thu, Feb 28, 2002 at 03:57:31PM -0600, Sandino Araico Sánchez wrote:
> > > The Oops happens after I use the ide-scsi module with my CDRW and then I
> > > plug the Zip USB in.
> >
> > Can you run the oops through ksymoops and send it to us?
> 
> ksymoops output attached.
> Invalid operand: 0000
> CPU:    0
> EIP: 0010: [<c01565f0>] Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 0000000d ebx: d010d8e0 ecx: dd384000 edx: 00000001
> esi: cd0d1a14 edi: c49a7d60 ebp: bfffe4cc esp: c1b7bf18
> ds: 0018 es: 0018 ss: 0018
> Process rmmod (pid: 24039, stackpage=c1b76000)
> Stack: c0244807 c02447ea c02447e0 d010d8e0 d010d8e0 c01575d8 d010d8e0 d010d2e0
>         d010d8e0 cd0d1a14 e090b362 d010d8e0 cd0d1a00 00000000 e0d5d3be cd0d1a14
>         00000600 00000000 c49a7d60 d010dee0 e0d5ea80 c01c544a c49a7d60 e0d5c000
> Call Trace: [<c01575d8>] [<e0d5d424>] [<e0d5d3be>] [<e0d5ea80>] [<c01c544a>] [<c01c555e>] [<e0d5ea80>] [<e0d5d424>] [<e0d5ea80>] [<c011980f>] [<c0118b12>]
>         [<c0106e23>]
> Code: 0f 0b 83 c4 10 f0 ff 4b 04 0f 94 c0 84 c0 0f 84 93 00 00 00 
> 
> >>EIP; c01565f0 <devfs_put+30/dc>   <=====
> Trace; c01575d8 <devfs_unregister+30/38>
> Trace; e0d5d424 <[usb-uhci]__module_license+9099/fcd5>
> Trace; e0d5d3be <[usb-uhci]__module_license+9033/fcd5>
> Trace; e0d5ea80 <[usb-uhci]__module_license+a6f5/fcd5>
> Trace; c01c544a <scsi_unregister_device+52/d4>
> Trace; c01c555e <scsi_unregister_module+36/3c>
> Trace; e0d5ea80 <[usb-uhci]__module_license+a6f5/fcd5>
> Trace; e0d5d424 <[usb-uhci]__module_license+9099/fcd5>
> Trace; e0d5ea80 <[usb-uhci]__module_license+a6f5/fcd5>
> Trace; c011980f <free_module+17/b4>
> Trace; c0118b12 <sys_delete_module+126/234>
> Trace; c0106e23 <system_call+33/38>

I suspect the USB-UHCI driver is doing a double-unregister on a devfs
entry. Please set CONFIG_DEVFS_DEBUG=y, recompile and boot the new
kernel. Send the new Oops (passed through ksymoops, of course).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbTCMU3k>; Thu, 13 Mar 2003 15:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbTCMU3k>; Thu, 13 Mar 2003 15:29:40 -0500
Received: from CPE00045a9153f8-CM0f0099801693.cpe.net.cable.rogers.com ([24.100.180.188]:5906
	"EHLO localhost") by vger.kernel.org with ESMTP id <S262523AbTCMU3i>;
	Thu, 13 Mar 2003 15:29:38 -0500
Message-ID: <3E70EF91.7070508@rogers.com>
Date: Thu, 13 Mar 2003 15:52:33 -0500
From: Aravind <aravind@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: mr, en-us, en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
References: <1047576167.1318.4.camel@ixodes.goop.org>
In-Reply-To: <1047576167.1318.4.camel@ixodes.goop.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig83733132656510923861C9D6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83733132656510923861C9D6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:
> I was reading back a freshly burned CD from my shiny new Plexwriter
> 48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted
> from /dev/scd0.  After reading for a while, apparently successfully, it
> started failing with the messages below:
> 
> spurious 8259A interrupt: IRQ7.
> hdc: lost interrupt
> ide-scsi: CoD != 0 in idescsi_pc_intr
> ide-scsi: abort called for 9677
> ide-scsi: abort called for 9674
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: status timeout: status=0x80 { Busy }
> hdc: drive not ready for command
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: status timeout: status=0x80 { Busy }
> hdc: drive not ready for command
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: status timeout: status=0x80 { Busy }
> hdc: drive not ready for command
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: ATAPI reset complete
> hdc: irq timeout: status=0x80 { Busy }
> hdc: status timeout: status=0x80 { Busy }
> hdc: drive not ready for command
> hdc: ATAPI reset complete

If I assume /dev/hdc is your CDROM drive then my machine also reports 
these errors. This happens on 2.4.x as well as 2.5.x. This is most 
probably due to loose connection in the CDROM drive. Mine is a HP
removable CDROM drive. If I re-insert it or "push" the drive module
in the slot the problem disappears. Sometimes the CDROM drive is 
identified as a removable floppy drive. Push the CDROM drive and reboot 
the kernel it is identified as proper CDROM drive. But never got a
kernel BUG.

Hope this information is useful.

Regards

Aravind



> ide-scsi: abort called for 9674
> ide-scsi: abort called for 9675
> ide-scsi: abort called for 9676
> ide-scsi: reset called for 9677
> ------------[ cut here ]------------
> kernel BUG at kernel/timer.c:155!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c011fc41>]    Tainted: PF
> EFLAGS: 00010002
> EIP is at add_timer+0xdb/0xe8
> eax: 00000001   ebx: c1b3b5e4   ecx: c0322820   edx: c03d33fc
> esi: 00000096   edi: c020b506   ebp: f7d8feac   esp: f7d8fea4
> ds: 007b   es: 007b   ss: 0068
> Process scsi_eh_0 (pid: 9, threadinfo=f7d8e000 task=c1b7cd00)
> Stack: 00000001 c1b3b5c0 f7d8fed0 c020b44c c1b3b5e4 00000000 00000082 00000000
>        00000000 c03d33fc c03d33fc f7d8ff00 c020baf4 c03d33fc c020b506 00000032
>        00000000 c1b3b5c0 c03d3350 00000096 00000000 c03d33fc c03d340c f7d8ff18
> Call Trace:
>  [<c020b44c>] ide_set_handler+0x48/0x74
>  [<c020baf4>] do_reset1+0x214/0x232
>  [<c020b506>] atapi_reset_pollfunc+0x0/0x11a
>  [<c020bb40>] ide_do_reset+0x2e/0x62
>  [<c02267b4>] idescsi_reset+0xc0/0xf6
>  [<c0220a36>] scsi_try_bus_device_reset+0x46/0x66
>  [<c0220abb>] scsi_eh_bus_device_reset+0x65/0x108
>  [<c0221224>] scsi_eh_ready_devs+0x28/0x74
>  [<c022137f>] scsi_unjam_host+0xa1/0xa4
>  [<c022142f>] scsi_error_handler+0xad/0xdc
>  [<c0221382>] scsi_error_handler+0x0/0xdc
>  [<c0107209>] kernel_thread_helper+0x5/0xc
> 
> Code: 0f 0b 9b 00 62 11 2e c0 e9 41 ff ff ff 55 31 c0 89 e5 83 ec
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
PGP Key: 0x52C72E39 at pgp.mit.edu


--------------enig83733132656510923861C9D6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+cO+qkHK5dFLHLjkRAvc8AKDoXIKYQDedgS9kk39QkOBUhDXHQACaAyZ0
CsQJplrDUFVM818QLWD16Jo=
=59+F
-----END PGP SIGNATURE-----

--------------enig83733132656510923861C9D6--


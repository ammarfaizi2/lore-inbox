Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282969AbRK0Vgs>; Tue, 27 Nov 2001 16:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282968AbRK0Vgj>; Tue, 27 Nov 2001 16:36:39 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:54617 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282969AbRK0Vg0> convert rfc822-to-8bit;
	Tue, 27 Nov 2001 16:36:26 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Slo Mo Snail <slomosnail@gmx.net>
Reply-To: slomosnail@gmx.net
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Tue, 27 Nov 2001 22:37:05 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011127204819Z282941-17408+21242@vger.kernel.org>
In-Reply-To: <20011127204819Z282941-17408+21242@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20011127213632Z282969-17409+18118@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I think the patch doesn't work :(
When I try to mount a CD over SCSI emulation I get this nice oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
Nov 27 22:24:00 slomosnail kernel:  printing eip:
Nov 27 22:24:00 slomosnail kernel: c01d0497
Nov 27 22:24:00 slomosnail kernel: *pde = 00000000
Nov 27 22:24:00 slomosnail kernel: Oops: 0000
Nov 27 22:24:00 slomosnail kernel: CPU:    0
Nov 27 22:24:00 slomosnail kernel: EIP:    0010:[idescsi_queue+1195/1508]   
Not tainted
Nov 27 22:24:00 slomosnail kernel: EFLAGS: 00010046
Nov 27 22:24:00 slomosnail kernel: eax: 00000000   ebx: c14cfda0   ecx: 
00000000   edx: c14cfda0
Nov 27 22:24:00 slomosnail kernel: esi: c0302000   edi: c14cfda0   ebp: 
c14cfda0   esp: cc401e5c
Nov 27 22:24:00 slomosnail kernel: ds: 0018   es: 0018   ss: 0018
Nov 27 22:24:00 slomosnail kernel: Process mount (pid: 192, 
stackpage=cc401000)
Nov 27 22:24:00 slomosnail kernel: Stack: 00000293 c15a5600 c15a5600 c15ba0c0 
00000014 cc9b89a0 c15a5658 c0302000
Nov 27 22:24:00 slomosnail kernel:        00000000 00000000 cc6ca4c0 c15e12c0 
c02fb2dc c01c582a c15a5600 c01ca8bc
Nov 27 22:24:00 slomosnail kernel:        c02925c0 c15a5600 c01cd214 c15a56b8 
00000000 c01cc434 c15a5600 c15a5600
Nov 27 22:24:00 slomosnail kernel: Call Trace: [scsi_dispatch_cmd+430/544] 
[scsi_old_done+0/1852] [scsi_init_io_v+0/392] [scsi_request_fn+1420/1440] 
[block_read_full_page+468/488]
Nov 27 22:24:00 slomosnail kernel:    [generic_unplug_device+37/44] 
[__run_task_queue+76/88] [block_sync_page+22/28] [___wait_on_page+101/140] 
[do_generic_file_read+828/1172] [generic_file_read+129/308]
Nov 27 22:24:00 slomosnail kernel:    [file_read_actor+0/92] 
[sys_read+143/196] [system_call+51/56]

Nov 27 22:24:00 slomosnail kernel: Code: 8b 51 04 8b 46 04 8d 14 52 83 c1 10 
89 04 91 8b 4f 1c 8b 46

After that the System is still responsible but a few minutes later I get this 
in a endless loop:
scsi : aborting command due to timeout : pid 30, scsi0, channel 0, id 1, lun 
0 0x28 00 00 00 00 00 00 00 02 00

I've tried
bh->bi_io_vec->bvl_vec[0].*
instead of
bh->bi_io_vec->bvl_vec->*
but I still get this errors
Maybe someone knows more... I don't

Bye


Am Dienstag, 27. November 2001 21:49 schrieb Sebastian Dröge:
> ok
> I've corrected it myself I think
> The patch is attached
> Hopefully it doesn't break something :)
> It's my first patch so please don't kill me
> Bye
>
> PS: sorry if/when you get this mail twice :(
> My mail client is a bit confused today
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BAeFvIHrJes3kVIRArcCAKCF51wrFnZ1RY+n2Qz2d6FhRti9LACgr/3G
ijxtXFVn7SqHc1XlDvEq0BA=
=ZqKg
-----END PGP SIGNATURE-----

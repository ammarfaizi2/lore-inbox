Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283042AbRK1N4K>; Wed, 28 Nov 2001 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282142AbRK1N4B>; Wed, 28 Nov 2001 08:56:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:53072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282144AbRK1Nz5> convert rfc822-to-8bit;
	Wed, 28 Nov 2001 08:55:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Wed, 28 Nov 2001 14:57:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: axboe@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011128135558Z282144-17408+22939@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jens,
your patch doesn't work for ide-scsi
I get this oops when trying to mount a CD:
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01cefff
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01cefff>]    Tainted: P
EFLAGS: 00010202
eax: 00000004   ebx: 00000014   ecx: 00000001   edx: 00000000
esi: 00000000   edi: c02fe628   ebp: c02fe600   esp: cdda3d6c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 189, stackpage=cdda3000)
Stack: 00000800 c15b5600 00000010 00000004 00000000 00000000 c02fe628 c02fe200
       00000000 00000400 00000000 c02fe000 c01cf22b c15b5600 00000800 c15b5600
       c02908e0 c01cbaf0 c15b56b8 00000068 c01cb73a c15b5600 00000286 cdda3e0c
Call Trace: [<c01cf22b>] [<c01cbaf0>] [<c01cb73a>] [<c01b22c1>] [<c01199f0>]
   [<c0134fb6>] [<c0134a71>] [<d099bc32>] [<c01cfdc1>] [<c0136458>] 
[<d099fd84>]   [<c0146fab>] [<c0136bfb>] [<d099fd84>] [<c0147d2a>] 
[<c0147af4>] [<c014854c>]   [<c0106b3b>]

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 54 24 34 0f b7 82

and this seems to be the same as with my patch
c01cefff seems to be sr_scatter_pad... because in System.map
there is: c01cee30 t sr_scatter_pad

it happens when I try to mount a CD. The drives are detected successfull

Maybe this helps you and when you need some more informations ask me

Bye

PS: I don't know why the tainted flag is set...
Only isofs and inflate_fs were loaded
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BO1RvIHrJes3kVIRApU9AJ4ydwvdiomS69lUKHB7nm8CXOzwtgCfR2+I
O1pxpk+ZdQ1J10KyW5YYvfU=
=Ew+a
-----END PGP SIGNATURE-----

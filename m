Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273952AbRIRVzv>; Tue, 18 Sep 2001 17:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273953AbRIRVzl>; Tue, 18 Sep 2001 17:55:41 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:58868 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S273952AbRIRVz1> convert rfc822-to-8bit; Tue, 18 Sep 2001 17:55:27 -0400
Date: Tue, 18 Sep 2001 22:55:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible bug in 2.4.9-ac10 (NTFS 1.1.18)
In-Reply-To: <20010918235042.A4164@dardhal.mired.net>
Message-ID: <Pine.SOL.3.96.1010918225401.18574A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep. This is fixed in NTFS 1.1.19 which is in 2.4.9-ac11 and later as well
as in 2.4.10-pre9 and later.

Anton

On Tue, 18 Sep 2001, José Luis Domingo López wrote:

> Hello kernel gurus:
> 
> I've experienced a rather nasty bug in NTFS read-only driver 1.1.18 as
> present on vanilla linux kernel 2.4.9-ac10. The bug can be triggered with
> a simple "find /" command, and it makes the machine to reject any further
> access to disks, but SysRq and network still work OK. The same test (which
> I'll detail in more detail below) causes no problems with vanilla linux
> kernel 2.4.9 (+ LVM 1.0.1 + devfs patch v.183), which includes NTFS driver
> version 1.1.6 (compiled just with RO support).
> 
> The test setup is as follows: machine in single user mode, no modules
> loaded except for ntfs.o and nls_iso8859-1.o. devfs is compiled in but not
> mounted on boot. Root filesystem (/dev/hda5) is of type ext2. Windows 2000
> workstation partition (/dev/hda1) is mounted read-only on /mnt/win2k. For
> the test, / is remounted read-only (to avoid looong fsck's on reboot :).
> 
> A simple "find /" goes as expected until it enters /mnt/win2k, where
> suddlenly the disks stop being accesed by the operating system. On both
> test I've done so far, the problem happens just after the directory
> "/mnt/win2k/Archivos de programa/Archivos comunes/Microsoft
> Shared/Stationery" (Archivos de programa == Program files, Archivos
> comunes == Common files). The machine still replies to pings, even gives
> you a "connect" when, for example, telnet to port 25, but no activity on
> the disks take place. SysRq still works, but any operation that tries to
> access to disks fail (SysRq+S or SysRq+U don't work).
> 
> I repeated the same test, but this time I "straced" it (strace find /). As
> said before, the machine stops accesing disks on the same directory as
> before. The last few lines from strace follow:
> 
> write(1,"/mnt/win2k/Archivos de programa"..., 96/mnt/win2k/Archivos de
> programa/Archivos comunes/Microsoft Shared/SpeechEngines/TTS/wttss22.dll
> ) = 96
> chdir("..") = 0
> lstat64(0x8050ca0,0xbfffee9c) = 0
> chdir("..") = 0
> lstat64(0x8050ca0,0xbfff04c) = 0
> lstat64(0x8057eea,0xbffff15c) = 0
> write(1,"/mnt/win2k/Archivos de programa/"...,77/mnt/win2k/Archivos de
> programa/Archivos comunes/Microsoft Shared/Stationery
> ) = 77
> open("Stationery",O_RDONLY|O_NONBLOCK|0x18000) = 4
> fstat64(0x4,0xbfffef6c) = 0
> shmat(4,0x8057eea,0x2ptrace:umoven:Input/output error
> ) = ?
> ipc_subcall(0x4,0x80582e0,0x400,0
> 
> And the system "hangs" there (I had to take note of the trace by hand, but
> I think I didn't miss anything). As said before, no problems with kernel
> 2.4.9 and driver 1.1.16.
> 
> Installed libc6 is version 2.2.4-1 (Debian Woody version).
> 
> If there are further tests needed to identify the problem, let me know and
> I'll do them with great pleasure :)
> 
> -- 
> José Luis Domingo López
> Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
>  
> jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
> jdomingo AT internautas DOT   org  => Spam at your own risk
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


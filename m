Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRJGJQQ>; Sun, 7 Oct 2001 05:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275852AbRJGJQG>; Sun, 7 Oct 2001 05:16:06 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:64271 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S275752AbRJGJP5> convert rfc822-to-8bit; Sun, 7 Oct 2001 05:15:57 -0400
Date: Sun, 7 Oct 2001 11:10:53 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: CaT <cat@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>, <groudier@club-internet.fr>
Subject: Re: sym53c1010 issues
In-Reply-To: <20011006094558.B440@zip.com.au>
Message-ID: <20011007101908.Y999-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Oct 2001, CaT wrote:

> Am currently getting the following errors in dmesg:
>
> sym53c1010-33-0:0: ERROR (81:0) (8-0-0) (3e/18) @ (mem 6d40383c:ffffffff).
                                                         ^^^^^^^^ ^^^^^^^^
The chips said 'Illegal Script Instruction detected'
This one let show the scripts processor jumping to some wrong memory
address.

> sym53c1010-33-0: regdump: da 00 00 18 47 3e 00 0f 04 08 80 00 00 00 0f 0a 28 96
> 7e 12 02 00 00 00.
> sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
> sym53c1010-33-0: restart (scsi reset).
> sym53c1010-33-0: handling phase mismatch from SCRIPTS.
> sym53c1010-33-0: Downloading SCSI SCRIPTS.
> sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
> sym53c1010-33-0:0: ERROR (81:0) (8-0-0) (3e/18) @ (script 50:f31c0004).
                                                               ^^^^^^^^
'Illegal Istruction' on a LOAD from memory DSA relative. This happen if
the DSA (base address) is not properly aligned regarding the size to load
(4).

> sym53c1010-33-0: script cmd = 90080000

> sym53c1010-33-0: regdump: da 00 00 18 47 3e 00 0f 00 08 80 00 00 00 0f 0a 0a 4d
> 5f 49 02 00 00 00.

The register dump shows DSA to be 495f4d0a which is indeed not a properly
aligned bus address. Probably some bogus value coming from screwed memory.

The both reports from the driver let me think that the driver internal
data have been corrupted from some obscure reason.


> sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
> sym53c1010-33-0: restart (scsi reset).
> sym53c1010-33-0: handling phase mismatch from SCRIPTS.
> sym53c1010-33-0: Downloading SCSI SCRIPTS.
> sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
>
> and, after about 24hrs, the box seizes upon me requireing a reboot. The
> kernel I'm using is 2.2.19 with raid0.9 and the latest sym* drivers (ie
> not the ones that come with the kernel).

You probably mean you are using sym53c8xx-1.7.3c. Btw, there is another
driver available called SYM-2. Current revision is 2.1.15, IIRC.
IMO, SYM-2 will also be victimized by the memory corruption that likely
originates from some other part of the kernel.

> The main thing here is that I'm not sure if this is a h/w or s/w issue. Would
> msgs like the above be due to the driver, the onboard scsi card or the HD?
>
> Or am I asking the wrong questions? :)

> There are other errors usually reported also and they deal with the 1st
> SCA drive (with 1 or 2 of the 3rd drive). There are currently 3 SCA drives
> on the first controller and 4 LVD drives (external array) on the 2nd. No
> hotswapping is being done and there have been no errors reported re the
> 4 LVD drives as far as I know.

The problem does not look SCSI-related. A SCSI error could be kind of
indirect cause that may trigger a bug in upper layers, but does not look
the direct cause at all.

> Anyone able to help?

I can't do more.

Regards,
  Gérard.



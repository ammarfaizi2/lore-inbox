Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTBRCAr>; Mon, 17 Feb 2003 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTBRCAr>; Mon, 17 Feb 2003 21:00:47 -0500
Received: from scrye.com ([216.17.180.1]:37043 "EHLO scrye.com")
	by vger.kernel.org with ESMTP id <S267543AbTBRCAp>;
	Mon, 17 Feb 2003 21:00:45 -0500
Date: 18 Feb 2003 02:10:39 -0000
Message-ID: <20030218021039.28335.qmail@scrye.com>
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x end of tape handling error
In-Reply-To: <200302101904.h1AJ4US05141@devserv.devel.redhat.com>
References: <mailman.1044901620.21591.linux-kernel2news@redhat.com>
	<200302101904.h1AJ4US05141@devserv.devel.redhat.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:

>> I have had reported from a client that they are having problems
>> with backups that span more than one tape. Instead of getting an
>> EOT error or EOM, they are getting an I/O error wich requires the
>> driver to be unloaded and reloaded before the tape will work again.
>> 
>> http://www.linuxtapecert.org/ Says that the redhat 2.4.9-34 kernel
>> is the last one that had proper EOT handling. Indeed, if they use
>> the 2.4.9-34 kernel, the tape works properly. Thats not a very good
>> solution however.

Pete> You neglected to mention what kind of tape it is. There are
Pete> several types of tapes, served by a jigsaw puzzle of various
Pete> drivers.

The problem was reported to me on a LTO scsi drive, but they also said
it happened on normal DAT drives. I am trying to get the exact model
and such on that drive. 

>> Is this fixed in the latest 2.4.21-pres? How about in 2.5.x?

Pete> Why don't you try and verify it, then let us know? You may be
Pete> the only guy in the world mad enough to use a tape with 2.5.x.
Pete> Please share your valuable expirience.

well, I have a HP dds2 drive here, so was happy to try and duplicate
the problem. Starting with the 2.4.18-24.7.x-i686-smp redhat kernel. 

In the interests of getting the problem to occur quickly, I
partitioned the dds2 tape into 2 partitions, the second having only
10mb in it. That doesn't show the problem. I get ENOSPC as expected at
the end of the small partition. 

Without partitions if I write more than can fit on a dds2 tape, I get: 

...
write(3, "r\342H\\5,\341\235\203\6\245`\264.C\303*\262\27qZ\343\305"..., 10240) = -1 EIO (Input/output error)
write(2, "tar: ", 5)                    = 5
write(2, "/dev/nst0: Wrote only 0 of 10240"..., 38) = 38
write(2, "\n", 1)                       = 1
write(2, "tar: ", 5)                    = 5
write(2, "Error is not recoverable: exitin"..., 37) = 37
write(2, "\n", 1)                       = 1
munmap(0x4002e000, 4096)                = 0
_exit(2)                                = ?

st0: Error with sense data: Info fld=0x28000, Current st09:00: sense key Medium Error
Additional sense indicates Write error
st0: Error with sense data: Info fld=0x0, Current st09:00: sense key Medium Error
Additional sense indicates Write error
st0: Error on write filemark.
st: Unloaded.

Sounds like it might be this issue: 

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&frame=right&th=85f41070543a0b41&seekm=DHn4y1.49t%40temic-ech.spacenet.de#s

I am trying another test with buffering off to see if that fixes it. 
Nope. Tried loading st with everything set to 0, no dice. 

Pete> -- Pete

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+UZYf3imCezTjY0ERAtaeAJsH7cwVy8HCkzHoUH+x4D0t1En0NACeMR91
osNsXmVCPrvFCDRrUQ3NPPk=
=9ji/
-----END PGP SIGNATURE-----

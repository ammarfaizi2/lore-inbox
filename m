Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbREPLJE>; Wed, 16 May 2001 07:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbREPLIz>; Wed, 16 May 2001 07:08:55 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:5265 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S261874AbREPLIs>;
	Wed, 16 May 2001 07:08:48 -0400
Date: Wed, 16 May 2001 12:08:44 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>,
        "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: LANANA: To Pending Device Number Registrants
Message-ID: <3201150370.990014924@[192.168.199.16]>
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F697322@FSKNMD07.hickam.af.mil>
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F697322@FSKNMD07.hickam.af.mil>
X-Mailer: Mulberry/2.1.0a5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe thats why there are persistant superblocks on the RAID
> partitions. You can switch them around, and it still knows which drive
> holds which RAID partition...  That's the only way booting off RAID
> works, and the only reason for the "RAID Autodetect" partition type...
> you can find those shuffled partitions correctly.  The only time it
> really looks at the file, is if you try to rebuild the partition I
> believe... and some other circumstance that dosn't come to mind.

OK. I obviously asked slightly the wrong question
as I was talking about a theoretical case and chose
badly.

What I meant was 'Wouldn't it be better to use some form of
static identifier / volume serial / MAC address / whatever, which
/dev/[device-type]/[ID] exactly identifies, and continues to
identify, even across config changes, than (a) go look
for these ID's, then (b) sequence them in number disk0..N so
that if one is removed, all the rest of them shuffle down'.
IE isn't the point being argued here: 'don't identify
devices by major/minor device number pairs chosen on
a rather arbitrary and wasteful basis which describes how
the given device is physically connected' and not 'the
devices shall be dynamically ordered 0..N and rely
on the order of detection, and the number of
other devices, to determine their numbering'.

As has been pointed out elsewhere, if you expose
/dev/disk/0/serial-number and/or
/dev/disk/0/interface/scsi/ whatever, in a
format trivially readable by a script, the problem
largely goes away (+/- a linear search). However,
if you don't at least try to keep (say) disk
names static across reboot with trivial
reconfig change (like inserting a PCMCIA
flash card), I can see people are going to
need to rewrite stuff like mount to look at
(say) an fstab where the first field is
not /dev/hda0, it is something which identifies
a disk beyond /dev/disk/0 and actually goes looks
at the tree under that for some form of serial
number (or whatever), or mount -a will produce
surprising results (for instance there's no
reason a PCMCIA flash card might not be
detected before a PCMCIA HD). I understood 2.4
was meant to be pretty static in terms of
external interface.

--
Alex Bligh

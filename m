Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129236AbRAaWG4>; Wed, 31 Jan 2001 17:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129209AbRAaWGg>; Wed, 31 Jan 2001 17:06:36 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:46605 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S129194AbRAaWGd>; Wed, 31 Jan 2001 17:06:33 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Modules and DevFS
In-Reply-To: <F148MamEWkeMEwuwi7N000015ef@hotmail.com>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 01 Feb 2001 09:05:58 +1100
In-Reply-To: w_knop@hotmail.com's message of "31 Jan 01 21:34:53 GMT"
Message-ID: <84ofwnjs1l.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Knop <w_knop@hotmail.com> writes:

    William> Correct me if I'm wrong, but DevFS only makes /dev
    William> entries when a device is present, and the device is not
    William> present until the module is loaded. So if I want to
    William> access /dev/hda and the IDE module has not been loaded
    William> yet, I will get a message telling me the device doesn't
    William> exist or some such instead of autoloading the module and
    William> being happy. Same goes for hotswap devices, right? I boot
    William> directly into X and have to crash out (otherwise it
    William> continually tries to unsuccessfully load X) so I could
    William> enable my USB mouse and various other devices.

My /etc/modutils/devfsd has

probeall  /dev/discs            scsi-hosts sd_mod ide-probe-mod ide-disk DAC960

perhaps it should have something similar for /dev/hd*?

As a work around, put something like this:

alias /dev/hdd         ide-cd

or (not tested; just guessing):

alias /dev/hd* /dev/ide

in /etc/modutils/aliases, and run update-modules.

    William> I realize modularizing the entire IDE subsystem is not
    William> really good anyway, because every time it reloads it will
    William> rescan the bus... But what about USB? Suppose I don't
    William> have any IDE or USB devices, but want support so I can
    William> use them later. Especially in the case of USB,
    William> plugability is a must for desktop "home" systems.

I am not really familiar with USB.
-- 
Brian May <bam@snoopy.apana.org.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

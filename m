Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLHPPu>; Fri, 8 Dec 2000 10:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQLHPPl>; Fri, 8 Dec 2000 10:15:41 -0500
Received: from Cantor.suse.de ([194.112.123.193]:22289 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129391AbQLHPPb>;
	Fri, 8 Dec 2000 10:15:31 -0500
Date: Fri, 8 Dec 2000 15:45:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Bernd Kischnick <kisch@mindless.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: patch: test12-pre7 cd stuff
Message-ID: <20001208154516.D303@suse.de>
In-Reply-To: <20001207195539.P6832@suse.de> <3A30EC28.1090203@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A30EC28.1090203@megapathdsl.net>; from miles@megapathdsl.net on Fri, Dec 08, 2000 at 06:11:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08 2000, Miles Lane wrote:
> Hi Jens,
> 
> I have tested your latest stuff (cd-2) with the CD that was
> causing problems before.  The problems still occur.
> The CD plays fine, but I get the following errors in
> my /var/log/messages:
> 
> Dec  8 06:05:29 agate kernel: hdc: packet command error: status=0x51 { 
> DriveReady SeekComplete Error }
> Dec  8 06:05:29 agate kernel: hdc: packet command error: error=0x50
> Dec  8 06:05:29 agate kernel: ATAPI device hdc:
> Dec  8 06:05:29 agate kernel:   Error: Illegal request -- (Sense key=0x05)
> Dec  8 06:05:29 agate kernel:   Invalid field in command packet -- 
> (asc=0x24, ascq=0x00)
> Dec  8 06:05:29 agate kernel:   The failed "Play Audio MSF" packet 
> command was:
> Dec  8 06:05:29 agate kernel:   "47 00 00 00 02 00 3f 24 ff 00 00 00 "
							   ^^

This should not happen, in fact it can't happen. That byte is the ending
frame, which is always modulo 75 (number of frames in a second). So how
this ends up 0xff is a mystery. I'll investigate...

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282275AbRLQTR6>; Mon, 17 Dec 2001 14:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282492AbRLQTRt>; Mon, 17 Dec 2001 14:17:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15123
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282491AbRLQTRc>; Mon, 17 Dec 2001 14:17:32 -0500
Date: Mon, 17 Dec 2001 11:11:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Domian Validation (Re: 2.5.1 - intermediate bio stuff..)
In-Reply-To: <Pine.LNX.4.33.0112161604030.11129-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10112170830400.17715-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

As to be completely clear on your point, you do not want any patches that
describe the rules for driver "domain validation".  Next, you do not want
any patches that fix gross things, too.  IE, exiting of any ISR's to
perform BH events.  Noting that one is not able to kludge it anymore, the
solution is to cut off the beast and start from scratch.

Now the significance of driver "domain validation", in block/storage is
the inner-play with the VM layer via a swap partition or file.

Until you can validate the new block io is correct at the data-transport
layer, where the requests are converted to the actual data-io to the disk
you have nothing but a WAG.  You will also have no way to separate issues
of FS/Memory corruption should it not be gone yet.  Otherwise you have to
disable any and all forms of SWAP real or file.

Since there is no way to validate the drivers and many believe it is
not important to perform such tests, how can you assure anyone given user
their data is safe?  Right now you are giving the impression that you do
not care about data integrity, and refusing to acknowledge this will
further prove you are in the same camp.

I remember all the crap taken over FS Corruption in the past, and now
present to you a perfect driver and a way to authenticate the data
transport and you thumb down the idea, directly or indirectly.  I had
plans to try and do the same for SCSI to become compliant to SPI 4, but
given the total rejection of layer isolateion for regression testing it
does not seem practical.  This is stated because the simple case is being
rejected so I see no way to even present the more complex case ever.

So do us all the favor by answering and explaining your position on the
scale of this sensitive issue.  I am sure everyone would like to hear your
views on the need or useless bloat that would result from having a
testable diskdrive data transport layer.

My bets are on you will call it "useless bloat".

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Sun, 16 Dec 2001, Linus Torvalds wrote:

> 
> I just made a 2.5.1, but I'm still concentrating on bio stuff, so don't
> bother sending me other patches unless they are serious bug-fixes to
> something else.
> 
> 2.5.1 is hopefully a good interim stage - many block drivers should work
> fine, but many more do not.  However, the pre-patches were getting
> largish, so I'd rather do a 2.5.1 than wait for all the details.
> 
> As to other stuff - note the separation of drivers for new and old tulip
> chips: if you have an old 2104x tulip chip (as opposed to the newer 2114x
> chips) the regular tulip driver doesn't work any more for you. Don't be
> surprised, select CONFIG_DE2104X.
> 
> 		Linus




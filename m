Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbRLRGFb>; Tue, 18 Dec 2001 01:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285612AbRLRGFM>; Tue, 18 Dec 2001 01:05:12 -0500
Received: from altus.drgw.net ([209.234.73.40]:62981 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S285604AbRLRGFE>;
	Tue, 18 Dec 2001 01:05:04 -0500
Date: Tue, 18 Dec 2001 00:04:32 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Domian Validation (Re: 2.5.1 - intermediate bio stuff..)
Message-ID: <20011218000432.C25200@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.33.0112161604030.11129-100000@penguin.transmeta.com> <Pine.LNX.4.10.10112170830400.17715-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10112170830400.17715-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Dec 17, 2001 at 11:11:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 11:11:23AM -0800, Andre Hedrick wrote:
> 
> Linus,
> 
> As to be completely clear on your point, you do not want any patches that
> describe the rules for driver "domain validation".  Next, you do not want
> any patches that fix gross things, too.  IE, exiting of any ISR's to
> perform BH events.  Noting that one is not able to kludge it anymore, the
> solution is to cut off the beast and start from scratch.
> 
> Now the significance of driver "domain validation", in block/storage is
> the inner-play with the VM layer via a swap partition or file.
> 
> Until you can validate the new block io is correct at the data-transport
> layer, where the requests are converted to the actual data-io to the disk
> you have nothing but a WAG.  You will also have no way to separate issues
> of FS/Memory corruption should it not be gone yet.  Otherwise you have to
> disable any and all forms of SWAP real or file.
> 
> Since there is no way to validate the drivers and many believe it is
> not important to perform such tests, how can you assure anyone given user
> their data is safe?  Right now you are giving the impression that you do
> not care about data integrity, and refusing to acknowledge this will
> further prove you are in the same camp.

Translation: Andre has been in a few too many ATA meetings and can't think 
without using storage industry insider-speak ;)

I only had a 6 months internship in storage, but I believe what he's 
talking about are sound engineering principles. 

The first of which is, if we are trying to find a problem in a complex 
system, you try and isolate that system from influences of others. And if 
you are trying to prevent new problems from showing up, you try and test 
each component of a complex system as an ongoing process.

Andre is focusing on the block IO layer here, because that's his area of
expertise. I think he points out a symptom of a problem that needs to be
addressed for damn near every area of the kernel.

We REALLY need to have some sort of coherent strategy for testing 
different components to determine whether they are worth putting in the 
mainline kernel, and catch bugs sooner. Yes, given enough eyeballs, all 
bugs are shallow, but given a little effort on setting up a an ongoing 
test system, we can reduce the workload of the 'core' kernel people by not 
having to have them sift through a bunch of useless bug reports because a 
user didn't know what we all know about debugging.

We need to have some way of isolating different subsystems, and a catalog
of 'regression tests' to verify that new changes aren't causing subsystems
to fail. I don't expect regression tests to be able to catch every
possible mistake, but I *DO* expect that we should be able to catch every
mistake we have previously made. This way a core kernel person only has to 
look debug a problem once, and write a test to catch it, instead of seeing 
the same problem over, and over, and over again from 300 different users.

> I remember all the crap taken over FS Corruption in the past, and now
> present to you a perfect driver and a way to authenticate the data
> transport and you thumb down the idea, directly or indirectly.  I had
> plans to try and do the same for SCSI to become compliant to SPI 4, but
> given the total rejection of layer isolateion for regression testing it
> does not seem practical.  This is stated because the simple case is being
> rejected so I see no way to even present the more complex case ever.
> 
> So do us all the favor by answering and explaining your position on the
> scale of this sensitive issue.  I am sure everyone would like to hear your
> views on the need or useless bloat that would result from having a
> testable diskdrive data transport layer.
> 
> My bets are on you will call it "useless bloat".
> 
> Regards,
> 
> Andre Hedrick
> CEO/President, LAD Storage Consulting Group
> Linux ATA Development
> Linux Disk Certification Project
> 
> On Sun, 16 Dec 2001, Linus Torvalds wrote:
> 
> > 
> > I just made a 2.5.1, but I'm still concentrating on bio stuff, so don't
> > bother sending me other patches unless they are serious bug-fixes to
> > something else.
> > 
> > 2.5.1 is hopefully a good interim stage - many block drivers should work
> > fine, but many more do not.  However, the pre-patches were getting
> > largish, so I'd rather do a 2.5.1 than wait for all the details.
> > 
> > As to other stuff - note the separation of drivers for new and old tulip
> > chips: if you have an old 2104x tulip chip (as opposed to the newer 2114x
> > chips) the regular tulip driver doesn't work any more for you. Don't be
> > surprised, select CONFIG_DE2104X.
> > 
> > 		Linus
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
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz

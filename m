Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUETPW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUETPW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 11:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUETPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 11:22:59 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:11278 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S265093AbUETPW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 11:22:57 -0400
Date: Thu, 20 May 2004 09:22:18 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com,
       Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: aic79xx trouble
Message-ID: <202980000.1085066538@aslan.btc.adaptec.com>
In-Reply-To: <20040518154816.GA1918@logos.cnet>
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de> <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de> <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr> <3436150000.1084731012@aslan.btc.adaptec.com> <20040518154816.GA1918@logos.cnet>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, May 16, 2004 at 12:10:12PM -0600, Justin T. Gibbs wrote:
>> >  The Adaptec Ultra320 cards (aic79xx) do not work reliably on Tyan Thunder
>> > motherboards.
>> 
>> The U320 chips likely work a lot better now if you use driver version 2.0.12.
>> The AMD chipsets seem to screw up split completions, and this version of
>> the driver avoids the issue for the most common case of triggering the
>> bug (transaction completion DMAs) by never crossing an ADB boundary with
>> a single DMA.
> 
> Hi Justin,
> 
> I've seen several reports of what seem to be aic7xxx driver bugs. And
> some of them you have stated that are fixed by your new driver.
> 
> I feel we should merge it in v2.4 mainline.  
> 
> Do you have any idea of how widely use your newer driver is?

Every user that sends a problem report to me is encouraged to use
the new drivers, and Adaptec only supports the newer drivers.  I
can't, however, give you a definitive number.

> For what reason the changes you made havent been merged in the past
> in mainline?

The latest drivers (6.3.X for aic7xxx and 2.0.X for aic79xx) perform
their own watchdog error recovery.  I made this change in order to overcome
deficiencies that exist in the SCSI mid-layer.  While there have been
discussions around fixing these problems in 2.6.X (and some have been
corrected there), I do not believe that the 2.4.X SCSI layer will ever
be fixed to allow the removal of this code.  So, as far as I can tell,
the complaints that have been raised about the latest drivers performing
private error recovery do not apply to 2.4.X and the latest drivers can be
merged there without controversy.

I have merged the latest drivers against linux-2.4 as of May 13th.
You can find bksend output containing all of the revisions to these
files since the last merge into 2.4.X, here:

http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20040513.bksend.gz

Should you decide to merge in the new drivers, please retain the
revision history.

Thanks,
Justin


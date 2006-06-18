Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWFREFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWFREFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 00:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWFREFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 00:05:20 -0400
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:59661 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S932081AbWFREFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 00:05:19 -0400
From: ocilent1 <ocilent1@gmail.com>
Reply-To: ocilent1@gmail.com
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: sound skips on 2.6.16.17
Date: Sun, 18 Jun 2006 12:04:29 +0800
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
References: <4487F942.3030601@att.net.mx> <200606172129.56986.kernel@kolivas.org> <20060618024130.GA32399@tuatara.stupidest.org>
In-Reply-To: <20060618024130.GA32399@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181204.29626.ocilent1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 10:41, Chris Wedgwood wrote:
> On Sat, Jun 17, 2006 at 09:29:56PM +1000, Con Kolivas wrote:
> > > > 1)  PCI-VIA-quirk-fixup-additional-PCI-IDs.patch
>
> that shouldn't break things, if it does I *really* want to know
>
> > > > 2)
> >
> > PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch
>
> nor should that, so again i would like to know if this is the one that
> makes a difference
>
> > > Works like a charm. End of the sound skips.
>
> what cpu/mainboard/etc

It is the 2nd patch 
(PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch) that is 
causing the sound stuttering/skipping problems for our users with VIA  
chipsets. Backing out the first patch alone did not fix the problem 
(PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back out the 2nd patch, 
you need to have  initially backed out the first patch, due to the way the 
patches apply in series.

Because I was too lazy to make a new patch which backs out only the 2nd patch 
(PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch) changes, 
I still have not confirmed if its the 2nd patch alone that is causing 
breakage, or if its a combination of both of them.

It took me a long time to track down this problem, as I was spending all my 
time looking at alsa related stuff, but then we finally found that it was 
infact anything above the 2.6.16.17 stable release that was breaking things. 
The obvious first target was to backout the VIA related changes made in the 
2.6.16.17 release and bingo.... my testers with VIA chipsets were happy 
again....

-- 
*ocilent1

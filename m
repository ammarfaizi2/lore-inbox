Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVGPNyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVGPNyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVGPNvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:51:54 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:29931 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261606AbVGPNuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:50:46 -0400
Date: Fri, 15 Jul 2005 10:38:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: resuming swsusp twice
Message-ID: <20050715083830.GC1772@elf.ucw.cz>
References: <20050713185955.GB12668@hexapodia.org> <42D67D84.2020306@suse.de> <20050714175447.GA16651@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714175447.GA16651@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I of course won't say that this cannot happen, but by design, the
> > swsusp
> > signature is invalidated even before reading the image, so
> > theoretically
> > it should not happen.
> 
> Yes, I'd seen that happen on earlier swsusps, so I was quite suprised
> when it blew up like this.
> 
> Perhaps the image should be more rigorously checked?  I'm wishing that
> it would verify that the header and the image matched, after it finishes
> reading the image.  For example, computing the hash
> 
> MD5(header || image)     (|| denotes "concatenate" in crypto pseudocode.)
> 
> and storing that hash in a final trailing block.  Additionally, of
> course, as soon as the resume has read the image it should overwrite the
> header; and the header should include jiffies or something along those
> lines to ensure that it won't accidentally have the same contents as the
> previous image's header.
> 
> The hash doesn't have to be MD5; even a CRC should suffice I think...

Actually, what you want is "if filesystems are newer than suspend
image, panic" test. There is more than one way how that can happen.

Are you sure you did not do

suspend kernel 1
boot kernel 2
attempt to suspend kernel 2 but fail ("not enough swap space")
boot kernel 1 ("and successfully resume, corrupting data")

?
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

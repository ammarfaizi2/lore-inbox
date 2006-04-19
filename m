Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWDSPfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWDSPfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWDSPfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:35:51 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:60689 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750908AbWDSPfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:35:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o5gZeB6QiQt4acVe+PgU6hUKxHPvwoNaAauz4F/146OhUHBr5VQaZZATo2/ebqqLDppcCqsO7/uHOcKQN5vdBIBWpapCDyzjI5WpjLQ1HgyN+PaDElSt6BptMpV0ZZgasM5gku660ceM/ehXqVUapby+b4OyNOu9yJ6vO76oqNw=
Message-ID: <b79f23070604190835ibf52c99u9194a4d0078b33d0@mail.gmail.com>
Date: Wed, 19 Apr 2006 08:35:22 -0700
From: "James Ausmus" <james.ausmus@gmail.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4445A3F3.6050907@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <62LaJ-6vK-5@gated-at.bofh.it> <62Wg0-6f8-29@gated-at.bofh.it>
	 <62WJ1-6Od-31@gated-at.bofh.it> <62WSE-70D-21@gated-at.bofh.it>
	 <631pe-5Gt-7@gated-at.bofh.it> <4445A3F3.6050907@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/06, Robert Hancock <hancockr@shaw.ca> wrote:
> James Ausmus wrote:
> > This is exactly the situation that I have with 2 separate "dumb" (just
> > physical interfaces, essentially - not at all detectable) IDE->CF
> > adapters - both the IDE controller and the CF media support several
> > UDMA modes, so the IDE driver throws the CF device into UDMA mode on
> > bootup. However, as the physical interface between the IDE cable and
> > the CF socket is poorly engineered, it cannot handle the higher
> > speeds, causing the timeout errors. For some people, this can just be
> > fixed with an ide=nodma boot option, but as I also have a (quite
> > large) rotating media device on the controller, this is not an option,
> > as, if a fsck is performed on a boot, the boot-up time is upwards of
> > 30 minutes.
>
> If it's like some of the CF-IDE adapters I've seen, the DMA request/ack
> lines likely aren't even wired up between the card and the cable.
> There's no way the kernel can detect that DMA is not actually possible
> on such a card without trying and waiting for it to timeout. (I've seen
> a few which have jumpers which select whether to connect these or not -
> haven't a clue why you wouldn't want to hook those up unconditionally..)
>
> Isn't there an option to disable DMA for a specific IDE channel
> (ide2=nodma or something like that)?
>

Yes, there is, but that unfortunately does not solve the issue for
configurations where there is also a UDMA capable device on the same
channel. If there was something like ide2=0:nodma,1:dma or some such,
in order to enable/disable dma on a per device basis, instead of a
per-channel basis, then that would also solve the issue.

-James


> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
>

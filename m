Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVD1Uos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVD1Uos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVD1UnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:43:20 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:13194 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262117AbVD1UlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:41:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SvT9YrDQGcs6ng4/YLnxtd/Z7xAHuJPD0ocHh1gL3Ig+0bJUspH3IeYdMYC7LqdKTLM6jyznvK+MoDHtHV/eiMVm9riK8P+CKsV7ESiAVvn1aomyiAvGBDpUbuy/zGf4s96Ix2iENNFTBapzhjYy/Tw5ows5Dd2ong3GD2hf6PE=
Message-ID: <58cb370e05042813414af5bc1e@mail.gmail.com>
Date: Thu, 28 Apr 2005 22:41:00 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1114703284.18809.208.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114703284.18809.208.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ages ago we added an ide_default driver to clean up all the corner cases

s/clean up/hide/

> like spurious IRQs for a device with no matching driver (eg ide-cd and
> no CD driver) as well as ioctls and file access.
>  
> 2.6.12rc removes it. Unfortunately it also means that if your only IDE
> interface is one you hand configure you can no longer run Linux. It also
> changes other aspects of behaviour although they don't look problematic
> for most users. You can no longer
>         - Control the bus state of an interface
>         - Reset an interface
>         - Add an interface if none exist
>         - Issue raw commands
>         - Get an objects bios geometry
>         - Read the identify data by ioctl (its still in proc but may be stale)

Details please.

> without having a device specific driver loaded matching the media - and
> that only works if its already detected the device correctly.
> 
> I don't have the tools at the moment to generate spurious IRQ's for
> devices with no driver loaded but it does look like the code may well
> then crash. From the way the changes were done it appears the current
> IDE maintainers never appreciated that ide_default existed for far more
> than just cleaning up ide-proc but also to handle IRQ's, opening of
> empty slots, ioctls and power
> management ?

Maybe you should mail current maintainer before spreading FUD?

No functionality was removed AFAIK, see the patches.  I spend quite 
a bit of time making sure that nothing breaks up (I missed one special
case but somebody already posted patch to LKML fixing it).

These patches were posted at least two times to both linux-ide and
linux-kernel, they were in -mm for ages - were you hiding under the
rock?

> The ability to specify the IDE ports on the command line as needed for
> some Sony laptop installs have also become "obsolete" over time. They
> still appear to work but spew a warning that the user will soon be
> screwed.

This was discussed few times already.

Alan, seriously, what is your problem?

Bartlomiej

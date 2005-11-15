Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVKON1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVKON1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVKON1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:27:11 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:10107 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932520AbVKON1J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:27:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k06u8kGrjJlaara5wThTe9Hok2TyMQFQryafz3jQlOFadwu+1UpnBXzFjbpfOjVeFqyB9M11I9BBCupZMedRCBkqA4kv+HE7mo4Xk02zxhCVG4w26tE4XljWqbl/roKyfbD99c2fiuOWngFOdmAUq2SgH1VjjiLg3oZV1zdb9Cc=
Message-ID: <58cb370e0511150527r415a1916t4fbadfc654a2bd18@mail.gmail.com>
Date: Tue, 15 Nov 2005 14:27:08 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105 interfaces
In-Reply-To: <20051112165548.GB28987@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
> chipsets where the southbridge revision is <= 5, otherwise data
> corruption will occur.
>
> Strangely this used to work, but something has changed in the upper
> echelons of the IDE layer to break the hosts decision to deny DMA.
> Let's make it crystal clear to the IDE layer that we know best.

Has it changed recently?

AFAICS this bug was introduced long time ago in the sl82c105
driver itself by setting hwif->autodma in init_hwif_sl82c105()
without checking for bridge revision:

http://linux.bkbits.net:8080/linux-2.6/patch@1.497.94.23?nav=index.html|src/|src/drivers|src/drivers/ide|src/drivers/ide/pci|related/drivers/ide/pci/sl82c105.c|cset@1.497.94.23

> Note: due to the urgency of this fix, I will be applying this to the
> ARM tree.  Any comments/criticisms can be dealt with further patches.

Fine with me.

Bartlomiej

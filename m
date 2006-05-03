Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWECC1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWECC1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 22:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWECC1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 22:27:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:31036 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWECC1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 22:27:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YsutkslpBOQCHASWH4i6Qm/VxdQSJ4Dp1Ax/BqNOFrT+uoya6Op3lA7SViqB1q10bHPLIth/ZhhBZSNvfLsGDKB4RjxNQtVYWn9bRDGbz6zkBP+BxcV1ZQQVQagEGSQdTnKhbTUwji+y0Fopd8E/DtZQm/kxmvwZ1wWSf3EeCwo=
Message-ID: <625fc13d0605021927l30ed3f86v48ad8fec9ec36051@mail.gmail.com>
Date: Tue, 2 May 2006 21:27:17 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Arnd Bergmann" <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <200605030200.29141.arnd@arndb.de>
	 <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Jared Hulbert <jaredeh@gmail.com> wrote:
> > Nice, this is the first time I heard of anyone using filemap_xip on MTD.
>
> Actually we don't use the MTD.  Well, we may use it to provide the
> physical address of the volume, thats not really _using_ it.

Can you explain a bit more?  If you aren't going to use the MTD, why
rely on it at all?

> >> - Design allows for tighter packing of data and higher performance
> >> than XIP cramfs
> >
> > why? by how much?
>
> Data packing:
> 1) When mkcramfs is writing files to the image it mixes compress and
> XIP files.  XIP files are page aligned.  Compressed files are not.  I
> think it was about 3.3% wasted I measured on an actual production
> linux phone.
> 2) Choosing page by page to XIP or compress means you can save space,
> but it depends on what is more precious, RAM or Flash, given real
> designs (ie - you don't buy 36MiB of RAM you get 32MiB or 64MiB)
>
> Performance:
> 1) The way we are storing the metadata should make for quicker access.
> 2) Being able to store specific pages of RO data from an otherwise XIP
> file such that they end up in RAM has speed thing up for us a great
> deal in the lab.

Have you done comparisons vs. squashfs at all?  It does better at both
performance and compression that cramfs, so I'm curious.

josh

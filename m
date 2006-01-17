Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWAQJCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWAQJCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWAQJCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:02:08 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:25788 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932355AbWAQJCG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:02:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SlNjwhZajnxhIrbaRqYt/Ykk/dNf1I9vBih1PzC9OfyuLLHAN6K/xGDw61CIMXJFVQJ78wR5vtRq/bOVQ2XI5l4FiXaaZT3o/qFjLqaQhkzqTTby57RRt/TL/DCGVa8SU4igsLe7OJ1xdGp1wmPlQM9ycgvSDa22CeGvF7Me9RM=
Message-ID: <58cb370e0601170102l491c1a1o7494416c6ae133d@mail.gmail.com>
Date: Tue, 17 Jan 2006 10:02:03 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15.1 Oops: rmmod ide-scsi
In-Reply-To: <20060116235103.GA9664@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116235103.GA9664@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Unfortunately this a known bug since at least 2.6.8 days:

http://bugzilla.kernel.org/show_bug.cgi?id=3568

Fixing would probably require adding reference counting on SCSI host.

On 1/17/06, Matthias Andree <matthias.andree@gmx.de> wrote:
> Greetings,
>
> playing with 2.6.15.1 a bit, I found that unloading ide-scsi causes two
> reproducible Oopsen here, and then the system locks up a short while
> later (with SysRq still functional so I can SysRq+B, but this corrupted
> an innocent .pyo file unrelated and even unaccessed during this time...)
>
> Procedure to reproduce:
>
> boot with init=/bin/bash added
>
> rmmod ide-cd      # SUSE loads this module from initrd
> modprobe ide-scsi
> rmmod ide-scsi    # <- oopses right after that with Oops #1
>                   #    and a few seconds later with Oops #2
>
> Enclosed: (1) the full dmesg and (2) .config (I fed the latter through
> egrep to ditch the comments and blank lines and sorted it for easy "is
> option XYZ set" retrieval).
>
> I don't think ide-cd is the culprit here, I can unload and reload it
> several times in a row without Oops.
>
> There be more dragons inside that module,
> but that's a different tale
> not to be told today.
>
> Regards,
>
> --
> Matthias Andree

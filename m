Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWGZB57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWGZB57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 21:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGZB57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 21:57:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:39604 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030356AbWGZB57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 21:57:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mcw+5PyN5f9qDjxkLyAGDuAz4OF5TG2M09Dk23nfTbqTtCLrK6xhwz/bVCYlD25rPXqj3qLZpX70TFao9sNYTztEO0EG5EPwVWCUIh++RO1YO2eCIYjq2JLFW1eO7+pgGe5RkEbP4KJfi/3adoyNJFhn1eI7aPZwd21k0gaBGKs=
Message-ID: <427c54c0607251857j2d56b901x7b016ba3260db245@mail.gmail.com>
Date: Tue, 25 Jul 2006 20:57:57 -0500
From: "Daniel De Graaf" <danieldegraaf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Rescan IDE interface when no IDE devices are present
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1153877304.7559.44.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
	 <1153077903.5905.35.camel@localhost.localdomain>
	 <427c54c0607161303r416c0dddt916a2b635c7431c5@mail.gmail.com>
	 <1153877304.7559.44.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2006-07-16 at 15:03 -0500, Daniel De Graaf wrote:
> > On 7/16/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > If you have ide1, you have both hdc and hdd (slave of hdc) unles sit's
> > > not really IDE ...
> > >
> > > Ben.
> >
> > Yes, I have /dev/hdd, but no device is ever present there. I also have
> > /dev/sda for the SATA hard disk, but do not think it is useful for
> > HDIO_SCAN_HWIF or HWIO_UNREGISTER_HWIF ioctls.
>
> There isn't. Feel free to write a module to do it (see how the ioctl
> handles it and follow the same logic). Its at best a hack. libata is
> trying to add proper hotplug for ATA/SATA.
>
> Alan

I wrote a module to do the register/unregister through a /proc file.
It currently only works on ide1; the constants in scan_hw and unreg_hw
should be made to depend on the value written to the /proc if other
interfaces are needed. Available at
http://danieldegraaf.afraid.org/linux/ide_proc_register.c

Daniel

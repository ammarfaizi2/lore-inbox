Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWBGIOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWBGIOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWBGIOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:14:33 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:46488 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750763AbWBGIOd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:14:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ooeHdoCfGDPz+liHNoGsMxpFdP5j+uXFjUjJUcIb5r4Cthb5HBFVFBL2D9m4gtD/8zGNfPDZpt+LYUPaqXyzfOs9zoa/aoA5WwHS87UBIOzhJqXkf2qq5zzEkkaPxqpyl+hbpU2U8y9DzeOp41rSBsv30uZLulfS71fkrdP7XdA=
Message-ID: <58cb370e0602070014p3d21c8a4u1ca3c5951892cf52@mail.gmail.com>
Date: Tue, 7 Feb 2006 09:14:27 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, William Park <opengeometry@yahoo.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1139257535.2791.298.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060206034312.GA2962@node1.opengeometry.net>
	 <1139200372.2791.208.camel@mindpipe>
	 <1139255365.10437.49.camel@localhost.localdomain>
	 <1139257535.2791.298.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-02-06 at 19:49 +0000, Alan Cox wrote:
> > On Sul, 2006-02-05 at 23:32 -0500, Lee Revell wrote:
> > > Generic and chipset specific support are not complementary, they are
> > > mutually exclusive.  Having generic PCI IDE support enabled will prevent
> > > the chipset specific support from working properly.
> >
> > Untrue.
> >
> > The PCI generic driver by default grabs only hardware with PCI IDS it
> > knows can be driven generically. That list purposefully has no overlaps
> > with chipset drivers.
>
> OK.  But wasn't this a problem in previous kernels?

It wasn't.  The issue is more complicated, you can have
three host drivers driving the same hardware:

* ide-generic driver
  - ISA like support
  - also works for PCI in legacy mode

* IDE PCI generic (the one Alan refers to)
  - generic IDE PCI support
  - by default doesn't grab IDs for which we have other drivers
    (can be forced by using kernel parameter)

* chipset specific driver

The most common mistake is to built-in ide-generic driver
and compile chipset specific driver as module...

To William:
CONFIG_IDE_GENERIC=n is a likely solution for your problem.

Bartlomiej

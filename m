Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269892AbUJSR4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269892AbUJSR4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269833AbUJSR0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:26:42 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:50448 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269897AbUJSRNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:13:36 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BmZSCogICOArmf6F0pk5x+HDbncY2W+aesl2+2y2WEAaM/j73d//1LgnGW2S0AsxfVYp6RLWj/yP/kUFEJAo/iS2WLQAFjh2EVzLUQFP7WNrJ+y+7WpHtRg9UD3xto4YrkMNyd8vMpPZ10X25nIilFXoJy4jhKpjhUh/Gjl4+R0
Message-ID: <8783be660410191013230a1b48@mail.gmail.com>
Date: Tue, 19 Oct 2004 13:13:34 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Johan Groth <jgroth@dsl.pipex.com>
Subject: Re: Dma problems with Promise IDE controller
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41753E1D.8010608@dsl.pipex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41741CDB.5010300@dsl.pipex.com>
	 <58cb370e04101813221d36b793@mail.gmail.com>
	 <8783be660410181420683d1341@mail.gmail.com>
	 <41753E1D.8010608@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 17:17:33 +0100, Johan Groth <jgroth@dsl.pipex.com> wrote:
> Ross Biro wrote:
> 
> 
> > On Mon, 18 Oct 2004 22:22:38 +0200, Bartlomiej Zolnierkiewicz
> > <bzolnier@gmail.com> wrote:
> >
> >>On Mon, 18 Oct 2004 20:43:23 +0100, Johan Groth <jgroth@dsl.pipex.com> wrote:
> >>
> >>>Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: error=0x40 {
> >>>UncorrectableError }, LBAsect=53500655, sector=53500520
> >
> >
> > The Uncorrectable Error is a dead give away.  You have a bad sector on
> > your drive.
> > 
> How am I supposed to fix those blocks? I've tried with e2fsck -c -c -y
> /dev/md0  but that yields the following printout in the log.
> 
The drive still has a bad sector.  You are having trouble because the
error recover in the Linux ide code is not the same as Windows and
most drive vendors care about Windows, not the ATA-Spec.  On top of
that Linux switches out of DMA mode once it hits a bad sector, so the
drive will be very slow from the on.

The only way you are going to fix the problem is if your drive has
some spare sectors still available, and you do a write with out a read
to the bad sector.

Ross

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbUB0X5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUB0X5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:57:33 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263179AbUB0X5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:57:16 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
Date: Sat, 28 Feb 2004 01:04:10 +0100
User-Agent: KMail/1.5.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <403F2178.70806@vanE.nl> <200402272114.23108.bzolnier@elka.pw.edu.pl> <Pine.LNX.4.58L.0402271950540.19454@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271950540.19454@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402280104.10523.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 of February 2004 23:51, Marcelo Tosatti wrote:
> On Fri, 27 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 27 of February 2004 20:01, Alan Cox wrote:
> > > On Gwe, 2004-02-27 at 19:30, Marcelo Tosatti wrote:
> > > > > > Haven't got a clue about these "status=0x51" and "error=0x04".
> > > > > > Anyone?
> > > > >
> > > > > Basically, the errors mean what they say - the drive is in an error
> > > > > state, (received an unrecognised command), but is ready for further
> > > > > operation.
> > > >
> > > > Received an unrecognised command from the kernel? What can cause
> > > > that?
> > >
> > > Our early setup/probing code in 2.4.x at least may send stuff that very
> > > very old disks don't understand. Its arguably a bug in the ident
> > > parsing but it shouldnt ever be harmful
> >
> > ide-disk.c sends WIN_READ_NATIVE_MAX_{EXT} without checking
> > if HPA feature set is supported, this is fixed in 2.6.x for a long time.
> >
> > We need 2.4<->2.6 IDE sync monkey... a really smart one...
>
> OK and what about the status=0x58 errors? What are those about?

These are from ide_wait_stat().  It looks like we are expecting drive to be
idle but drive is ready to receive data.  There should be another error
message in logs (unless error comes from ide-cd.c) telling more what was
the source of an error.

Bartlomiej


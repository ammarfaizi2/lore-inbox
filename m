Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284703AbRLEU4G>; Wed, 5 Dec 2001 15:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLEUz7>; Wed, 5 Dec 2001 15:55:59 -0500
Received: from mailf.telia.com ([194.22.194.25]:1276 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S284703AbRLEUzb>;
	Wed, 5 Dec 2001 15:55:31 -0500
Message-Id: <200112052055.fB5KtHe00692@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Andrew Morton <akpm@zip.com.au>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
Date: Wed, 5 Dec 2001 21:53:07 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112051713200.2297-100000@mustard.heime.net> <3C0E7FEE.2770EDF4@zip.com.au>
In-Reply-To: <3C0E7FEE.2770EDF4@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 December 2001 21:13, Andrew Morton wrote:
> Roy Sigurd Karlsbakk wrote:
> > hi all
> >
> > I've just upgraded to 2.4.16 to get /proc/sys/vm/(max|min)-readahead
> > available. I've got this idea...
> >
> > If lots of files (some hundered) are read simultaously, I waste all the
> > i/o time in seeks. However, if I increase the readahead, it'll read more
> > data at a time, and end up with seeking a lot less.
> >
> > The harddrive I'm testing this with, is a cheap 20G IDE drive.
>
> /proc/sys/vm/*-readhead is a no-op for IDE.  It doesn't do
> anything.   You must use
>
> 	echo file_readahead:100 > /proc/ide/ide0/hda/settings
>
> to set the readhead to 100 pages (409600 bytes).

Make that kB!
(page sizes is an implementation detail that depends on architecture, 
compilation options...)

(for Andrew:
 it multiplies with 1024 then divides by PAGE_SIZE, result is in pages.
 If you wanted to set no of pages then the scaling should be *1/1...
 earlier it only multiplied with 1024...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316259AbSEKS4H>; Sat, 11 May 2002 14:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316260AbSEKS4G>; Sat, 11 May 2002 14:56:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65023 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316259AbSEKS4G>;
	Sat, 11 May 2002 14:56:06 -0400
To: Jens Axboe <axboe@suse.de>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linus Torvalds <torvalds@transmeta.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56) 
In-Reply-To: Your message of Sat, 11 May 2002 16:24:34 +0200.
             <20020511142434.GA1224@suse.de> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15427.1021141513.1@us.ibm.com>
Date: Sat, 11 May 2002 11:25:13 -0700
Message-Id: <E176bYP-00040t-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020511142434.GA1224@suse.de>, > : Jens Axboe writes:
> On Sat, May 11 2002, Roy Sigurd Karlsbakk wrote:
> > On Friday 10 May 2002 17:55, Linus Torvalds wrote:
> > > On Fri, 10 May 2002, Lincoln Dale wrote:
> > > > so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no
> > > > O_DIRECT. anyone have any clues?
> > >
> > > Yes.
> > >
> > > O_DIRECT isn't doing any read-ahead.
> > >
> > > For O_DIRECT to be a win, you need to make it asynchronous.
> > 
> > Will the use of O_DIRECT affect disk elevatoring?
> 
> No, the I/O scheduler can't even tell whether it's being handed
> O_DIRECT buffers or not.

We tried disabling the elevator while doing Raw IO with DB2
a couple of weeks ago.  The database performance degraded much
more than expected.  Disks were FC connected Tritons or SCSI
connected ServerRaid (or both?).  Oracle often asks for a patch
to disable the elevator since they believe they can schedule IO
better.  We didn't try with Oracle in this case, but DB2 and RAW
IO without and elevator was not a good choice.

gerrit

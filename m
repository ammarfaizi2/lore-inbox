Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRHYQ3u>; Sat, 25 Aug 2001 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269673AbRHYQ3k>; Sat, 25 Aug 2001 12:29:40 -0400
Received: from mailf.telia.com ([194.22.194.25]:31463 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S269632AbRHYQ33>;
	Sat, 25 Aug 2001 12:29:29 -0400
Message-Id: <200108251629.f7PGTiQ19557@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
Date: Sat, 25 Aug 2001 18:25:19 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200108242253.f7OMrbQ20401@mailf.telia.com> <200108250055.f7P0tGh28170@mailg.telia.com> <20010825135508.5afe1988.skraw@ithnet.com>
In-Reply-To: <20010825135508.5afe1988.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday den 25 August 2001 13:55, Stephan von Krawczynski wrote:
> On Sat, 25 Aug 2001 02:48:28 +0200
>
> Roger Larsson <roger.larsson@norran.net> wrote:
> > Hi again,
> >
> > [two typos corrected from the version at linux-mm]
> > [...]
> > Doing this - the code started to collaps...
> > __alloc_pages_limit could suddenly handle all special cases!
> > (with small functional differences)
> >
> > Comments?
>
> Hi Roger,
>
> I tested your page against straight 2.4.9 (where it applied mostly, the
> rest I did manually) and experience the following: 
> 1) system gets slow, even in times where plenty of free memory is
> available. There must be some overhead inside.

It is not unlikely because it care too much about the higher order 
allocations. It needs a higher order page and really tries...

> 2) It does not really work around the basic problem of too
> many cached pages in case of heavy filesystem action, I do get the already
> known "kernel: __alloc_pages: 2-order allocation failed." by simply copying
> files a lot. 

Is this with raiserfs and/or nfs? And without highmem support?
Why is 2-order allocations needed???
Can anyone answer?
Higher order allocs during normal operation is not that nice...

> 3) Even in high load situations the CPU load seems to get
> worse, I made it up to 7 with normal file copying on a SMP 1GHz 1GB RAM
> machine.

Might also be related to the higher order. Freeing too much inactive pages
to satisfy the request...
SMP might be a factor since the patch will go harder on the locks...

>
> Hm, I guess that doesn't really work as you expected.

Well, I make a version that gives up on higher order allocations more 
quickly...

But the real problem might be - why are the higher order allocations
needed anyway?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

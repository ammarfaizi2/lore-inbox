Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287932AbSAPVpU>; Wed, 16 Jan 2002 16:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSAPVpK>; Wed, 16 Jan 2002 16:45:10 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:62735 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288997AbSAPVor>; Wed, 16 Jan 2002 16:44:47 -0500
Date: Wed, 16 Jan 2002 18:31:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102281244290.551-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102280713550.7480-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Mike Galbraith wrote:

> On Wed, 28 Feb 2001, Marcelo Tosatti wrote:
> 
> > On Wed, 28 Feb 2001, Mike Galbraith wrote:
> >
> > > > > Have you tried to use SWAP_SHIFT as 4 instead of 5 on a stock 2.4.2-ac5 to
> > > > > see if the system still swaps out too much?
> > > >
> > > > Not yet, but will do.
> >
> > But what about swapping behaviour?
> >
> > It still swaps too much?
> 
> Yes.
> 
> (returning to study mode)

Ok, I'm stupid. Changing SWAP_SHIFT will just balance the nr of tasks and
the per-task nr of scanned pte's, but the not (roughly) the total nr of
ptes scanned. I thought it would decrease the number of scanned ptes from
3% (which the current in -ac code does) to 0.3% (which Linus tree does) of
the total ptes.

The problem seems to be multiple users calling swap_out() with 3% of ptes
being scanned. This will unmap ptes way too heavily for common workloads.

Its magic number tuning.. but nothing better can be done for 2.4, I think.




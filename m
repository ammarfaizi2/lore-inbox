Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbRETVLF>; Sun, 20 May 2001 17:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262136AbRETVKz>; Sun, 20 May 2001 17:10:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3077 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262220AbRETVKj>; Sun, 20 May 2001 17:10:39 -0400
Date: Sun, 20 May 2001 16:32:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105201943510.1635-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105201626190.5547-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Mike Galbraith wrote:

> > Also in all recent kernels, if the machine is swapping, swap cache
> > grows without limits and is hard to recycle, but then again that is
> > a known problem.
> 
> This one bugs me.  I do not see that and can't understand why.

To throw away dirty and dead swapcache (its done at swap writepage())
pages page_launder() has to run into its second loop (launder_loop = 1)
(meaning that a lot of clean cache has been thrown out already).

We can "short circuit" this dead swapcache pages by cleaning them in the
first page_launder() loop.

Take a look at the writepage() patch I sent to Linus a few days ago.


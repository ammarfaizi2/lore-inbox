Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277403AbRJEOwq>; Fri, 5 Oct 2001 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277400AbRJEOwe>; Fri, 5 Oct 2001 10:52:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15366 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277407AbRJEOwO>; Fri, 5 Oct 2001 10:52:14 -0400
Subject: Re: [POT] Which journalised filesystem ?
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 5 Oct 2001 15:57:49 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110042054490.4835-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Oct 04, 2001 08:55:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pWQA-0006bs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We (as in Linux) should make sure that we explicitly tell the disk when
> > we need it to flush its disk buffers. We don't do that right, and
> > because of _our_ problems some people claim that writeback caching is
> > evil and bad.
> 
> Does this even work right for IDE ?

Current IDE drives it may be a NOP. Worse than that it would totally ruin
high end raid performance. We need to pass write barriers. A good i2o card
might have 256Mb of writeback cache that we want to avoid flushing - because
it is battery backed and can be ordered.

By all means have drivers fall back to cache writeback, but don't assume
that is the basic operation.

Indeed a smarter raid card can generally do

	"read"
	"read with readahead"
	"read with readahead and some readahead on card only"
	"read but dont cache"

	"write to cache"
	"write through cache"
	"write uncached"

Alan

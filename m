Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSGKR1I>; Thu, 11 Jul 2002 13:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317873AbSGKR1H>; Thu, 11 Jul 2002 13:27:07 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:43281 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317872AbSGKR1G>; Thu, 11 Jul 2002 13:27:06 -0400
Date: Thu, 11 Jul 2002 19:28:48 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
Message-ID: <20020711192848.A793@nightmaster.csn.tu-chemnitz.de>
References: <3D2A5F34.F38B893F@torque.net> <3D2A6608.7C43EE3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3D2A6608.7C43EE3@zip.com.au>; from akpm@zip.com.au on Mon, Jul 08, 2002 at 09:26:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 09:26:48PM -0700, Andrew Morton wrote:
> Ben had lightweight sg structures called `kvecs' and `kveclets'. And
> library functions to map pages into them.  And code to attach them
> to BIOs.  So we'll be looking at getting that happening.

Ok, I've looked at them and they don't help me at all. 

A user, who splits its IO into single pages, wants to do DMA and
needs bus addresses for that. So he needs "struct scatterlist".

If one doesn't need to DMA, one can do copy_{from,to}_user
directly with an immediate buffer, so the splitup isn't needed.

For this I conclude, that using the EXISTING 'struct scatterlist'
will be enough for both. Attaching a vector of these to the BIOs
is no problem. Neither it is for CHARACTER device IOs (CIOs).

So by using this simple abstraction we MIGHT waste only 4-8 bytes
per page submitted, but by page-splitting the IO only for devices,
that need DMA (e.g. make the request that explicitly) we don't
really waste it and support BIOs and CIOs the same way.

I will refine that code for my own uses anyway, so if nobody with
more clues about IO than me implements it, I will submit it
later.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSEZWTT>; Sun, 26 May 2002 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316212AbSEZWTS>; Sun, 26 May 2002 18:19:18 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:27667 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316194AbSEZWTQ>; Sun, 26 May 2002 18:19:16 -0400
Date: Sun, 26 May 2002 23:42:24 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SB16: 2.4.18 lockup on odd-numbered 16bit sound input
Message-ID: <20020526234224.I635@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020525132644.GA3095@andi.hausnetz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 03:26:44PM +0200, Andreas Mohr wrote:
> I think the main question that this revolves around is what to do with
> odd-numbered/misaligned write() input in case of multi-byte audio formats.
> Should the kernel
> 1) discard odd remainders
> 2) tell the user program by returning incomplete counts that it discarded it
> 3) buffer unprocessable remainders for use in the next write()
> ?

2) Was the right answer for my own driver set, because it will
   not loose data and is a common situation the user space app is
   supposed to handle properly. 

The only arguable case is if we use a count of 0 after 
calculating (count & (align-1)), because we would basically
return EOF here instead of a short read (in  the read case).

But it can be worked around by disallowing seeks or contraining the
seeks ;-)

PS: I know, we are talking about (short) writes here, but the
   topic needs insight and I just handled these problems recently.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

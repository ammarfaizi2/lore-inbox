Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTD2A3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 20:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTD2A3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 20:29:40 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:28552 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261422AbTD2A3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 20:29:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>, rmoser <mlmoser@comcast.net>
Subject: Re: Swap Compression
Date: Tue, 29 Apr 2003 10:43:48 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200304251832440510.00D02649@smtp.comcast.net> <3EAD9E94.2000602@techsource.com>
In-Reply-To: <3EAD9E94.2000602@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304291043.48825.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003 07:35, Timothy Miller wrote:
> rmoser wrote:
> >Yeah you did but I'm going into a bit more detail, and with a very tight
> > algorithm.  Heck the algo was originally designed based on another
> > compression algorithm, but for a 6502 packer.  I aimed at speed,
> > simplicity, and minimal RAM usage (hint:  it used 4k for the code AND the
> > compressed data on a 6502, 336 bytes for code, and if I turn it into just
> > a straight packer I can go under 200 bytes on the 6502).
> >
> >Honestly, I just never looked.  I look in my kernel.  But still, the stuff
> > I defined about swapon options, swap-on-ram, and how the compression
> > works (yes, compressed without headers) is all the detail you need about
> > it to go do it AFAIK.  Preplanning should be done there--done meaning
> > workable, not "the absolute best."
>
> I think we might be able to deal with a somewhat more heavy-weight
> compression.  Considering how much faster the compression is than the
> disk access, the better the compression, the better the performance.
>
> Usually, if you have too much swapping, the CPU usage will drop, because
> things aren't getting done.  That means we have plenty of head room to
> spend time compressing rather than waiting.  The speed over-all would go
> up.  Theoretically, we could run into a situation where the compression
> time dominates.  In that case, it would be beneficial to have a tuning
> options which uses a less CPU-intensive compression algorithm.

The work that Rodrigo De Castro did on compressed caching 
(linuxcompressed.sf.net) included a minilzo algorithm which I used by default 
in the -ck patch addon as it performed the best for all the reasons you 
mention. Why not look at that lzo code for adoption.

Con

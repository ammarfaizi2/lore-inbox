Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSBRWja>; Mon, 18 Feb 2002 17:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288834AbSBRWjT>; Mon, 18 Feb 2002 17:39:19 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:25744 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288800AbSBRWjI>;
	Mon, 18 Feb 2002 17:39:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH] size-in-bytes
Date: Mon, 18 Feb 2002 23:43:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200202161609.QAA31164.aeb@cwi.nl>
In-Reply-To: <UTC200202161609.QAA31164.aeb@cwi.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cwVW-0000jf-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 16, 2002 05:09 pm, Andries.Brouwer@cwi.nl wrote:
> I just rediffed the size-in-bytes patch against 2.5.5pre1.
> The result is found at ftp.kernel.org
> (under 02-2.5.5pre1-sizeinbytes-bsd), and below.
> 
> Comment:
> Disk and partition size is kept several places, sometimes
> in sectors (of 512 bytes), sometimes in blocks (of 1024 bytes).
> This is ugly, one finds a lot of shifting left and right, as in
> 	limit = (size << BLOCK_SIZE_BITS) >> sector_bits;

We want to stay with the shift counts.  They should be the primary currency
of size measurement.  You can add shift counts together and get nice, compact
code, whereas with absolute size you often have to ugly things - e.g., it's a
pain to divide by blocksize when you have it as an absolute number, it's easy
when you have it as a shift.

If you are going to the trouble of fixing this, please don't use absolute
size as the primary measure, use a shift count.

--
Daniel

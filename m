Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSFOUTA>; Sat, 15 Jun 2002 16:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSFOUS7>; Sat, 15 Jun 2002 16:18:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315525AbSFOUS7>;
	Sat, 15 Jun 2002 16:18:59 -0400
Message-ID: <3D0BA21A.5C81E6A@zip.com.au>
Date: Sat, 15 Jun 2002 13:22:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO 
 simplification
In-Reply-To: <200206152001.NAA02740@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> >- It's tricky to determine how many bvecs are available in
> >  a bio.  There is no straightforward "how big is it" field
> >  in struct bio.
> 
>         Can't I make a macro to do a table lookup from bio->bi_max?

Not really.  If I do

	bio_alloc(GFP_KERNEL, 27);

then I'll get a 32-slot bvec.  But presumably, I don't
want to put more than 27 pages into it.

-

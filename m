Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279950AbRKVQW7>; Thu, 22 Nov 2001 11:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279984AbRKVQWt>; Thu, 22 Nov 2001 11:22:49 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:60331 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S279950AbRKVQWj>;
	Thu, 22 Nov 2001 11:22:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: "Elgar, Jeremy" <JElgar@ndsuk.com>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 08:22:08 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <F128989C2E99D4119C110002A507409801C52F89@topper.hrow.ndsuk.com>
In-Reply-To: <F128989C2E99D4119C110002A507409801C52F89@topper.hrow.ndsuk.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166wc5-0004WA-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 22, 2001 08:11, Elgar, Jeremy wrote:
> Hum think I'm going to test this idea out tonight, quick question without
> swap at what point would the kernel stop giving memory up for cache
> purposes. For example I noticed on Tuesday whist doing a back up of a file
> system (in-line tar cd untar) I was left with ~4 Mb left having nearly the
> rest of my 2Gb Ram used for cache.

The general idea behind VM is pretty simple: keep the most frequently used 
pages in the fastest storage possible. The tar backup pushed a lot of pages 
that looked more frequently used in to RAM, and swapped out programs that 
weren't being used at all in favour of this cache. Now that the backup is 
completed, and only a small portion of the cache you used for backup is being 
used, these unused cache pages can very easily be 'given up' to be used as 
free memory again. A VM that -doesn't care- if it's dealing with program 
pages, buffer pages, shared memory, or cache pages when making swapping 
decisions is much more robust than a VM that tries to 'outsmart' itself.

-Ryan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSACFut>; Thu, 3 Jan 2002 00:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288200AbSACFuj>; Thu, 3 Jan 2002 00:50:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:59396 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287633AbSACFuY>; Thu, 3 Jan 2002 00:50:24 -0500
Message-ID: <3C33F01E.EC95DD82@zip.com.au>
Date: Wed, 02 Jan 2002 21:46:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kees <kees@schoen.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] solves freeze due to serial comm. on SMP
In-Reply-To: <Pine.LNX.4.33.0201022257001.12316-200000@schoen3.schoen.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kees wrote:
> 
> Hi,
> 
> In the beginning of last year I reported a solid freeze problem with Linux
> when I moved from UP to SMP. Some bughunting especially with kdb an hints
> from AM I was able to nail it down to some SMP unsafe irq table handling
> in serial.c.
> I submitted the attached patch to Ted but that never made it to the
> kernel. It _really_ solved the problem as I had a crash sometimes within
> 15 minutes and after applying it I reached uptimes over 100 days.
> 

It looks like somebody has already had a go at fixing this in current
kernels - the restore_flags() has been moved to the end of
shutdown().  (It's not a complete fix, because request_irq() can
schedule).

Are you able to test 2.4.17?

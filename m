Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbTCHUsm>; Sat, 8 Mar 2003 15:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTCHUsm>; Sat, 8 Mar 2003 15:48:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:54487 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262218AbTCHUsj>;
	Sat, 8 Mar 2003 15:48:39 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Mar 2003 21:59:14 +0100 (MET)
Message-Id: <UTC200303082059.h28KxES05315.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] register_blkdev
Cc: akpm@digeo.com, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We need to get rid of the artifical major/minor split completly

I do not disagree with you, but your point of view seems
to be that either we make everything perfect or we do nothing.
I prefer slow progress.

Concerning this split - traces of it occur in a very large
number of places. Let me just mention the raw device that
I did this afternoon. How does one connect a raw device
with a block device? Using a struct raw_config_request
from user space. And look

struct raw_config_request
{
        int     raw_minor;
        __u64   block_major;
        __u64   block_minor;
};

One of the many places that has a built-in major/minor split.
Basically this split is unimportant. A dev_t is just a cookie.
But as soon as you start looking at details this split is
all over the place.

Andries

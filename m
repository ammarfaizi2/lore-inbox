Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319376AbSHQJlK>; Sat, 17 Aug 2002 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319377AbSHQJlK>; Sat, 17 Aug 2002 05:41:10 -0400
Received: from mail.zmailer.org ([62.240.94.4]:15801 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S319376AbSHQJlJ>;
	Sat, 17 Aug 2002 05:41:09 -0400
Date: Sat, 17 Aug 2002 12:45:07 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: nada shalabi <nadashshsh@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: important question!
Message-ID: <20020817094507.GB32427@mea-ext.zmailer.org>
References: <F232Dd3OJXsNQptgFrY00000068@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F232Dd3OJXsNQptgFrY00000068@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:22:24AM +0000, nada shalabi wrote:
> hi,
> i want to add a comprissing syscall in the linux kernel in order
> to improve the work of the swapper.

Could you describe how the improvement would be achieved
with this ?  Under what conditions ?

> The commprissing function and the decomprissing one take a buffer
> as an argument.now i am trying to find the right line to insert
> the compriss and decompriis in  i meen the place in thre code
> before the buffer of data became a page and after a page become
> a buffer od data.
> i still searching and reading the linux code i think my answer
> should be in page_io.c.
> please help me i need the answer today.
> thanx in advance
> nada shalabi

You don't want to make a syscall -- those are where kernel supplies
some service for the userspace.   What you do want is to add a block
compression function call within the kernel itself.

Now if that thing you have in mind would make sense, why it hasn't
been done in past 10 years ?  (It has been proposed a few times, though.)

That is due to:
 - You can't compress compressed data
 - In worst case, you end up needing MORE space than you
   begun with   (even one bit more space is too much.)

Sure enough it might work for most of the time, but when you get a page
full of maximum entropy data, and try to swap that, things fail.

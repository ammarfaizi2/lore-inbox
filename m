Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRKDTEx>; Sun, 4 Nov 2001 14:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRKDTEe>; Sun, 4 Nov 2001 14:04:34 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25614 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273261AbRKDTE2>; Sun, 4 Nov 2001 14:04:28 -0500
Message-ID: <3BE59009.79CBED53@zip.com.au>
Date: Sun, 04 Nov 2001 10:59:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mau <mau@oscar.prima.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14-pre8: 'free' still reports bogus 'cached' value.
In-Reply-To: <20011104132238.A14511@oscar.dorf.de> <3BE58886.FBCAEDB5@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> It's a bug in the /proc code.  If buffercache pages exceed
> pagecache pages, `pg_size' flips negative.
> 
> There doesn't seem to be any reason to subtract buffermem_pages
> from page_cache_size - they're independent.
> 

Well that was crap, wasn't it?  Wrong kernel.

I wonder if it's due to the fact that grow_dev_page()
calls find_or_create_page(), but we increment the
buffermem_pages count unconditionally, whether or
not the page was newly created?

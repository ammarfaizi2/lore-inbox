Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSADXMe>; Fri, 4 Jan 2002 18:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSADXMQ>; Fri, 4 Jan 2002 18:12:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:10003 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285093AbSADXMJ>; Fri, 4 Jan 2002 18:12:09 -0500
Message-ID: <3C3635A8.447EE52E@zip.com.au>
Date: Fri, 04 Jan 2002 15:07:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
        bcrl@redhat.com
Subject: Re: hashed waitqueues
In-Reply-To: <20020104094049.A10326@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> This is a long-discussed space optimization for the VM system, with
> what is expected to be a minor time tradeoff.

Nice code.

> ...
> +       /*
> +        * Although the default semantics of wake_up() are
> +        * to wake all, here the specific function is used
> +        * to make it even more explicit that a number of
> +        * pages are being waited on here.
> +        */
> +       if(waitqueue_active(page_waitqueue(page)))
> +               wake_up_all(page_waitqueue(page));

Does the compiler CSE these two calls to page_waitqueue()?
All versions?   I'd be inclined to do CSE-by-hand here.

Also, why wake_up_all()?  That will wake all tasks which are sleeping
in __lock_page(), even though they've asked for exclusive wakeup
semantics.  Will a bare wake_up() here not suffice?

-

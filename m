Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBMKLx>; Tue, 13 Feb 2001 05:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRBMKLn>; Tue, 13 Feb 2001 05:11:43 -0500
Received: from zeus.kernel.org ([209.10.41.242]:24772 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129258AbRBMKLY>;
	Tue, 13 Feb 2001 05:11:24 -0500
Date: Tue, 13 Feb 2001 10:08:37 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: george anzinger <george@mvista.com>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, Rik van Riel <riel@conectiva.com.br>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
Message-ID: <20010213100837.O20696@redhat.com>
In-Reply-To: <20010129222337.F603@jaquet.dk> <Pine.LNX.4.21.0101291929120.1321-100000@duckman.distro.conectiva> <20010129224311.H603@jaquet.dk> <3A88A6ED.6B51BCA9@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A88A6ED.6B51BCA9@mvista.com>; from george@mvista.com on Mon, Feb 12, 2001 at 07:15:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 12, 2001 at 07:15:57PM -0800, george anzinger wrote:
> Excuse me if I am off base here, but wouldn't an atomic operation be
> better here.  There are atomic inc/dec and add/sub macros for this.  It
> just seems that that is all that is needed here (from inspection of the
> patch).

The counter-argument is that we already hold the page table lock in
the vast majority of places where the rss is modified, so overall it's
cheaper to avoid the extra atomic update.

Cheers,
 Stephen

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbREZPa0>; Sat, 26 May 2001 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbREZPaJ>; Sat, 26 May 2001 11:30:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54534 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261471AbREZP24>;
	Sat, 26 May 2001 11:28:56 -0400
Date: Sat, 26 May 2001 12:28:53 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260812280.3684-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105261226400.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Linus Torvalds wrote:

>                 if (gfp_mask & __GFP_WAIT) {
>                         memory_pressure++;
> -                       try_to_free_pages(gfp_mask);
> -                       goto try_again;
> +                       if (!order || free_shortage()) {
> +                               int progress = try_to_free_pages(gfp_mask);
> +                               if (progress || gfp_mask & __GFP_IO)
> +                                       goto try_again;
> +                       }
>                 }

Yes, this is it.

> Testing is good. But I want to understand how we get into the
> situation in the first place, and whether there are ways to alleviate
> those problems too.

As I said  create_buffers() -> get_unused_buffer_head()
-> __alloc_pages() -> loop infinitely.

Your simplification of get_unused_buffer_head() fits in
nicely with this.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


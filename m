Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313803AbSDPSCA>; Tue, 16 Apr 2002 14:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313805AbSDPSB7>; Tue, 16 Apr 2002 14:01:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:57952 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313798AbSDPSB5>; Tue, 16 Apr 2002 14:01:57 -0400
Date: Tue, 16 Apr 2002 20:01:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: aliasing bug in blockdev-in-pagecache?
Message-ID: <20020416200147.M29747@dualathlon.random>
In-Reply-To: <20020413235948.E4937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 11:59:48PM +0100, Stephen C. Tweedie wrote:
> --- fs/buffer.c.~1~	Fri Apr 12 17:59:09 2002
> +++ fs/buffer.c	Sat Apr 13 21:09:36 2002
> @@ -1902,9 +1902,14 @@
>  	}
>  
>  	/* Stage 3: start the IO */
> -	for (i = 0; i < nr; i++)
> -		submit_bh(READ, arr[i]);
> -
> +	for (i = 0; i < nr; i++) {
> +		struct buffer_head * bh = arr[i];
> +		if (buffer_uptodate(bh))
> +			end_buffer_io_async(bh, 1);
> +		else
> +			submit_bh(READ, bh);
> +	}
> +	
>  	return 0;
>  }

looks fine from my part too, thanks!

Andrea

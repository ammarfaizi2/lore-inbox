Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbQJ2HLp>; Sun, 29 Oct 2000 02:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbQJ2HLf>; Sun, 29 Oct 2000 02:11:35 -0500
Received: from Cantor.suse.de ([194.112.123.193]:43019 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131532AbQJ2HLa>;
	Sun, 29 Oct 2000 02:11:30 -0500
Date: Sun, 29 Oct 2000 08:11:23 +0100
From: Andi Kleen <ak@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org,
        netdev <netdev@oss.sgi.com>
Subject: Re: tcp.c::wait_for_tcp_memory() buggy ?
Message-ID: <20001029081123.A18126@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0010290122050.4224-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010290122050.4224-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sun, Oct 29, 2000 at 01:28:38AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 01:28:38AM -0200, Rik van Riel wrote:
> Except for doing a test on tcp_memory_free(sk), where we
> do NOT hold the lock we're so dutifully clinging to during
> the rest of the loop...

And rechecking it later while holding the loop on the next iteration.

Also usually the caller also does a check again and iterates as needed.

> 
> As I said, I can't put my finger down on what exactly is
> wrong, but this code looks subtle enough that, together
> with the bugreport I got (on IRC), I have the feeling that
> it just _can't_ be right ...

With the right setup of multiple threads writing all the time
on a single socket you could probably starve one, making it loop forever here.
(it does not try to be fair) 



-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132727AbRDUPx5>; Sat, 21 Apr 2001 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132728AbRDUPxs>; Sat, 21 Apr 2001 11:53:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:779 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132727AbRDUPxg>;
	Sat, 21 Apr 2001 11:53:36 -0400
Date: Sat, 21 Apr 2001 12:48:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Venkatesh Ramamurthy <venkateshr@softhome.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: pageable kernel-segments
In-Reply-To: <20010420195150.A7325@redhat.com>
Message-ID: <Pine.LNX.4.21.0104211236340.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Stephen C. Tweedie wrote:
> On Fri, Apr 20, 2001 at 03:49:30PM +0100, Alan Cox wrote:
> 
> > There is a proposal (several it seems) to make 2.5 replace the conventional
> > unix swap with a filesystem of backing store for anonymous objects. That will
> > mean each object has its own vm area and inode and thus we can start blowing
> > away all user mode page tables when we want.
> 
> Not without major VM overhaul.
> 
> The problem is MAP_PRIVATE, where a single vma can contain both normal
> file-backed pages and anonymous pages at the same time.  You don't
> even know whose anonymous page it is --- a process with anon pages can
> fork, so that later on some of the child's anon pages actually come
> from the parent's anon space instead of the child's.

Whoooops indeed. I forgot about this mess...

> Right now all of the magic that makes this work is in the page tables.
> To remove page tables we'd need additional structures all through the
> VM to track anonymous pages, and that's exactly where the FreeBSD VM
> starts to get extremely messy compared to ours.

That's because they still seem to use Mach's object chaining.

There's bound to be a much cleaner solution than whatever it
is they copied over from Mach ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


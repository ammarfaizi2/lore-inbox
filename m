Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131859AbQL2Swd>; Fri, 29 Dec 2000 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbQL2SwY>; Fri, 29 Dec 2000 13:52:24 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:6665 "HELO kamov.deltanet.ro")
	by vger.kernel.org with SMTP id <S131859AbQL2SwI>;
	Fri, 29 Dec 2000 13:52:08 -0500
Date: Fri, 29 Dec 2000 20:21:20 +0200
From: Petru Paler <ppetru@ppetru.net>
To: Jakob Østergaard <jakob@unthought.net>,
        Andrea Arcangeli <andrea@suse.de>, Jure Pecar <pegasus@telemach.net>,
        linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229202120.C573@ppetru.net>
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net> <20001229032953.A9810@athlon.random> <20001229034712.B9810@athlon.random> <20001229093840.A792@ppetru.net> <20001229165340.C12791@athlon.random> <20001229200421.A8543@ppetru.net> <20001229191328.A12468@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <20001229191328.A12468@unthought.net>; from jakob@unthought.net on Fri, Dec 29, 2000 at 07:13:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 07:13:28PM +0100, Jakob Østergaard wrote:
> > > It can't scale in SMP.
> > 
> > No one said it does, but it works nicely on UP.
> 
> What ?

Maybe you got me wrong (my english isnt that good): I said that it does
not scale on SMP, but it works just fine on UP.

> The TCP stack is threaded, so things like checksum calculation will
> take advantage of multiple processors - right ?

Wrong. "Threaded" TCP/IP stack -> fine grained locking, not "multiple
threads".

> Thes rest of the work is roughly copying data that isn't already
> cached from the disk into memory.  Well, you have one disk so threads
> will buy you zero there.
> 
> Unless you do blocking I/O on the files or on the sockets, I fail to
> see how threads could possibly boost the performance on a web server
> that serves *static*only* pages.

They do boost performance on SMP (because you can have N (N=nr. of CPUs)
threads serving data).

> (The reason I'm curious is because I'm about a month away from implementing
>  something that would run high-bandwidth TCP transfers and I'm planning
>  on keeping it single-threaded - unless someone can tell me that's a bad
>  idea)

Keep it single threaded if you run on UP only...

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

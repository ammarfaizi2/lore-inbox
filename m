Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRA3Lij>; Tue, 30 Jan 2001 06:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129360AbRA3Li3>; Tue, 30 Jan 2001 06:38:29 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:52081
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129282AbRA3LiT>; Tue, 30 Jan 2001 06:38:19 -0500
Date: Tue, 30 Jan 2001 12:38:12 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Chris Wedgwood <cw@f00f.org>, "David S. Miller" <davem@redhat.com>,
        David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
Message-ID: <20010130123812.O3298@jaquet.dk>
In-Reply-To: <20010131001737.C6620@metastasis.f00f.org> <Pine.LNX.4.21.0101300921480.1321-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101300921480.1321-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Jan 30, 2001 at 09:23:27AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 09:23:27AM -0200, Rik van Riel wrote:
> Why bother ?
> 
> In most places where we update mm->rss, we are *already*
> holding the spinlock anyway, this correction is just for
> a few places.
> 
> The big patch Rasmus made seems to contain spin_lock(&foo)
> in places where we already have the lock, leading to
> instant SMP deadlock. I suspect Rasmus' patch should be
> about half the size it is currently...

After donning my brown paper bag yesterday I looked at 
the call-paths again and removed one more lock pair
(the one in swapfile). The others seemed OK so I made 
a SMP-on-UP kernel and ran my usual stuff (X, mozilla, 
kernel compiles) alongside mmap001, mmap002 and misc001
with no ill effects.

I will beat on it some more today and tomorrow, but if
real SMP is needed for testing I need some help to do
that.


Regards,
   Rasmus 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRACVjn>; Wed, 3 Jan 2001 16:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbRACVje>; Wed, 3 Jan 2001 16:39:34 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:23565
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129324AbRACVj2>; Wed, 3 Jan 2001 16:39:28 -0500
Date: Thu, 4 Jan 2001 10:39:24 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Chris Mason <mason@suse.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
Message-ID: <20010104103924.B28974@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10101031027090.1896-100000@penguin.transmeta.com> <466640000.978548970@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <466640000.978548970@tiny>; from mason@suse.com on Wed, Jan 03, 2001 at 02:09:30PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 02:09:30PM -0500, Chris Mason wrote:

    The problem with [mf]sync is that we really want to write the
    page before returning back to the application.

We don't _want_ to -- we MUST. Some applications assume fsync and
fdatasync work correctly; if they do not the all bests are off.

This includes many MTAs, MDAs and databases (msync also being
important).

Looping somewhere before returning to the application is by far
better than returning when some pages have yet to be flushed.



  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

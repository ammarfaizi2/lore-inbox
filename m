Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268710AbRHBEmq>; Thu, 2 Aug 2001 00:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbRHBEmg>; Thu, 2 Aug 2001 00:42:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39179 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268710AbRHBEmY>; Thu, 2 Aug 2001 00:42:24 -0400
Date: Thu, 2 Aug 2001 01:42:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <bristuccia@starentnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: repeated failed open()'s results in lots of used memory [Was:
 [Fwd: memory consumption]]
In-Reply-To: <Pine.GSO.4.21.0108012118060.27494-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33L.0108020138560.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Alexander Viro wrote:
> On Wed, 1 Aug 2001, Linus Torvalds wrote:
>
> > However, I'd like to see what the patch does for the bad case first, and
> > then we can see whether there are less drastic methods (like only killing
> > half of the negative dentries or something).
>
> Removing the "second chance" logics for negative dentries might
> be a good start...

Both the "second chance" logic and pure fifo are bad.

Something like Daniel Phillips' "use once" logic would
be fine for dentries, possibly even simpler.

Dentries could start their live at the head of the
"active" list so they are the first to be moved to
the "reclaim me" list.

If they get referenced while on the second list,
we move them to the tail of the active list.

As a balancing rule, we could tune the system to
always keep half of the dentries in the "reclaim me"
list.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


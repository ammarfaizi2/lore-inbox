Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2SoX>; Fri, 29 Dec 2000 13:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbQL2SoD>; Fri, 29 Dec 2000 13:44:03 -0500
Received: from unthought.net ([212.97.129.24]:18069 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S129930AbQL2Sn4>;
	Fri, 29 Dec 2000 13:43:56 -0500
Date: Fri, 29 Dec 2000 19:13:28 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Petru Paler <ppetru@ppetru.net>
Cc: Andrea Arcangeli <andrea@suse.de>, Jure Pecar <pegasus@telemach.net>,
        linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229191328.A12468@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Petru Paler <ppetru@ppetru.net>, Andrea Arcangeli <andrea@suse.de>,
	Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
	thttpd@bomb.acme.com
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net> <20001229032953.A9810@athlon.random> <20001229034712.B9810@athlon.random> <20001229093840.A792@ppetru.net> <20001229165340.C12791@athlon.random> <20001229200421.A8543@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20001229200421.A8543@ppetru.net>; from ppetru@ppetru.net on Fri, Dec 29, 2000 at 08:04:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 08:04:21PM +0200, Petru Paler wrote:
> On Fri, Dec 29, 2000 at 04:53:40PM +0100, Andrea Arcangeli wrote:
> > On Fri, Dec 29, 2000 at 09:38:40AM +0200, Petru Paler wrote:
> > > This is one of the main thttpd design points: run in a select() loop. Since
> > > it is intended for mainly static workloads, it performs quite well...
> > 
> > It can't scale in SMP.
> 
> No one said it does, but it works nicely on UP.

What ?

The TCP stack is threaded, so things like checksum calculation will
take advantage of multiple processors - right ?

Thes rest of the work is roughly copying data that isn't already
cached from the disk into memory.  Well, you have one disk so threads
will buy you zero there.

Unless you do blocking I/O on the files or on the sockets, I fail to
see how threads could possibly boost the performance on a web server
that serves *static*only* pages.

99% of the real work is done by the kernel, so whether you have your
user-space application threaded or not should not be an issue - the
way that I see it...

Andrea, or someone else, would you care to enlighten me on that ?

(The reason I'm curious is because I'm about a month away from implementing
 something that would run high-bandwidth TCP transfers and I'm planning
 on keeping it single-threaded - unless someone can tell me that's a bad
 idea)

Thanks,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

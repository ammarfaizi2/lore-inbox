Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbRFTWsC>; Wed, 20 Jun 2001 18:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbRFTWrv>; Wed, 20 Jun 2001 18:47:51 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18602 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263070AbRFTWrk>;
	Wed, 20 Jun 2001 18:47:40 -0400
Message-ID: <3B312807.F58DB4ED@mandrakesoft.com>
Date: Wed, 20 Jun 2001 18:47:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org,
        Larry McVoy <lm@bitmover.com>, Victor Yodaiken <yodaiken@fsmlabs.com>
Subject: [OT] Re: Why use threads ( was: Alan Cox quote?)
In-Reply-To: <XFMail.20010620154145.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On 20-Jun-2001 David Schwartz wrote:
> >
> >> On Wed, Jun 20, 2001 at 02:01:16PM -0700, David Schwartz wrote:
> >
> >> >    It's very hard to use processes for this purpose. Consider,
> >> > for example, a
> >> > web server. You don't want to use one process for each client
> >> > because that
> >> > would limit your scalability (16,000 clients would become difficult, and
> >> > with threads it's trivial). You don't want to use one thread
> >> > for each client
> >
> >> How is it trivial? How do you debug a 16,000 thread application?
> >
> >       As I said, you don't want to use one thread for each client. You use,
> > say, 10 threads for the 16,000 clients.
> 
> Humm, you're going to select() over 1600 fds ...

Sigh, this is offtopic for a while, and I am not helping ;-)

A well-designed app should not be selecting 100% of its fds, but only
those fd's that need selecting...

If you are talking about a single application with 16,000 clients,
personally, I would use thread pools:  a few threads for doing poll(2),
a few threads for doing work, etc.  Anything above that is unlikely to
scale with demand.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |

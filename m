Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278315AbRJSGNz>; Fri, 19 Oct 2001 02:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278316AbRJSGNq>; Fri, 19 Oct 2001 02:13:46 -0400
Received: from maild.telia.com ([194.22.190.101]:63951 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S278315AbRJSGNj>;
	Fri, 19 Oct 2001 02:13:39 -0400
Message-Id: <200110190614.f9J6E5A18498@maild.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: George Greer <greerga@m-l.org>
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
Date: Fri, 19 Oct 2001 08:08:50 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110182252050.13061-100000@bacon.van.m-l.org>
In-Reply-To: <Pine.LNX.4.33.0110182252050.13061-100000@bacon.van.m-l.org>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 04:53, you wrote:
> On Thu, 18 Oct 2001, Roger Larsson wrote:
> >On Thursday 18 October 2001 04:01, Leo Mauro wrote:
> >> Small fix to Linus's sample code
> >>
> >>  	unsigned int so_far = 0;
> >>  	for (;;) {
> >>  		int bytes = read(in, buf+so_far, BUFSIZE-so_far);
> >>  		if (bytes <= 0)
> >>  			break;
> >>  		so_far += bytes;
> >>  		if (so_far < BUFSIZE)
> >>  			continue;
> >>  		write(out, buf, BUFSIZE);
> >> - 		so_far = 0;
> >> +		so_far -= BUFSIZE;
> >>  	}
> >>  	if (so_far)
> >>  		write(out, buf, so_far);
> >>
> >> to avoid losing data.
> >
> >I was close to press the send button but noticed the "BUFSIZE-so_far"
> >in the read call, just in time(TM).
> >
> >If it had not been there you would have needed to copy data from the
> >end of buf (from above BUFSIZE) to the beginning of buf too...
> >(the required size of buf would have been 2*BUFSIZE)
>
> Since you only ever have BUFSIZE bytes when you write, aren't:
>
>   so_far -= BUFSIZE;
>
> and
>
>   so_far = 0;
>
> identical? I'd say the assignment to 0 would be faster.

I was not specific enough. I intended to say that Linus code was ok.
And that if so_far -= BUFSIZE ever was something different from
zero you would need to move the read bytes too...

This code not using continue is probably easier to read...
(+ error checking...)

  	unsigned int so_far = 0;
  	for (;;) {
  		int bytes = read(in, buf+so_far, BUFSIZE-so_far);
  		if (bytes <= 0)
  			break;
  		so_far += bytes;
 		if (so_far == BUFSIZE) {
	  		write(out, buf, BUFSIZE);
 			so_far = 0;
		}
  	}
  	if (so_far)
  		write(out, buf, so_far);


/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

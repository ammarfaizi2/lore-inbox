Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbRGYXiA>; Wed, 25 Jul 2001 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbRGYXhv>; Wed, 25 Jul 2001 19:37:51 -0400
Received: from [47.129.117.131] ([47.129.117.131]:48771 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S267431AbRGYXha>; Wed, 25 Jul 2001 19:37:30 -0400
Message-ID: <3B5F5830.253C2E0D@nortelnetworks.com>
Date: Wed, 25 Jul 2001 19:37:20 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <Pine.LNX.4.33.0107251615430.22383-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus Torvalds wrote:
> 
> On Thu, 26 Jul 2001, Andrea Arcangeli wrote:
> >
> > I will if Honza assures me that no future version of gcc will cause me to
> > crash if I don't declare xtime volatile and I play with it while it can
> > change under me (which seems not the case from his last email).
> 
> WHY DO YOU NOT ADD THE "VOLATILE" TO THE PLACES THAT _CARE_?
> 
> This is not a gcc issue. Even if gcc _were_ to generate bad code, the
> global volatile _still_ wouldn't be the correct answer.

I think his worry is the pedantic reason that without the volatile gcc is
allowed to write code that chokes and dies if xtime happens to change in a
volatile manner.  The example given earlier was:

code as written:
	kprintf("%d\n",xtime.tv_usec);

code as compiled by gcc (with xtime not specified as volatile):
	suseconds_t temp = xtime.tv_usec;
	if (temp != xtime.tv_usec)
		BUG();
	kprintf"%d\n",temp);

I hope that gcc would not do such a thing, but I think a case could be made that
it could do it and still comply with the language standard.

Of course, since the linux kernel is an important thing for gcc to compile, I
can't imagine them doing something that would break it on purpose without a
really good reason.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

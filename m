Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268344AbRGWVPh>; Mon, 23 Jul 2001 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268346AbRGWVP2>; Mon, 23 Jul 2001 17:15:28 -0400
Received: from [47.129.117.131] ([47.129.117.131]:48512 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S268344AbRGWVPM>; Mon, 23 Jul 2001 17:15:12 -0400
Message-ID: <3B5C93C9.8DF406CC@nortelnetworks.com>
Date: Mon, 23 Jul 2001 17:14:49 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Friesen, Christopher [CAR:VS16:EXCH]" <cfriesen@americasm01.nt.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <E15OmlH-0007R9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> > Suppose I loop against xtime reaching a particular value.  While this is
> 
> xtime isnt used this way that I can see. jiffies however is. There are good
> arguments for getting rid of most [ab]use of jiffies however. For one its
> pretty important to scaling on both big mainframes and beowulf setups doing
> heavy computation to reduce timer ticks

jiffies is (as of 2.4.7 anyways) marked as volatile, so we're safe there.  My
point is this--should someone writing badly designed (but technically correct)
code be able to totally hose the system?

The only difference between volatile and normal is that if it is marked as
volatile it must be accessed every time rather than being pre-cached.  If we
never spin on accessing xtime, then the fact that we can't optimize it shouldn't
hurt. (Am I wrong here?  If I am then please explain because I'm missing
something...)  If someone ever *does* spin on xtime, then we really don't want
to optimize that access out of the loop, because doing so could cause nasty
problems.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265148AbRGEWaj>; Thu, 5 Jul 2001 18:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbRGEWa3>; Thu, 5 Jul 2001 18:30:29 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39696 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265148AbRGEWaR>; Thu, 5 Jul 2001 18:30:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Davide Libenzi <davidel@xmailserver.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Date: Fri, 6 Jul 2001 00:33:18 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010705144521.davidel@xmailserver.org>
In-Reply-To: <XFMail.20010705144521.davidel@xmailserver.org>
MIME-Version: 1.0
Message-Id: <0107060033180K.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 July 2001 23:45, Davide Libenzi wrote:
> On 05-Jul-2001 David Woodhouse wrote:
> > davidel@xmailserver.org said:
> >> This patch add a new linux/macros.h that is supposed to host utility
> >> macros that otherwise developers are forced to define in their files.
> >> This version contain only min(), max() and abs().
> >
> > Consider min(x++,y++). Try:
> >
> >#define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y);
> > (_x>_y)?_y:_x; #})
> >#define max(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y);
> > (_x>_y)?_x:_y; #})
>
> Yep, it's better.

This program prints garbage:

	#define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x; })
	
	int main (void) { 
		int _x = 3, _y = 4; 
		printf("%i\n", min(_x, _y)); 
		return 0; 
	}

--
Daniel

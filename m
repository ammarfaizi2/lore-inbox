Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSBSUcR>; Tue, 19 Feb 2002 15:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289820AbSBSUbC>; Tue, 19 Feb 2002 15:31:02 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:7153 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289858AbSBSUaZ>; Tue, 19 Feb 2002 15:30:25 -0500
Message-ID: <3C72B5C1.2D339F9B@mvista.com>
Date: Tue, 19 Feb 2002 12:29:53 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jakob Kemi <jakob.kemi@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conversion routines.
In-Reply-To: <Pine.LNX.4.33.0202191000340.26476-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 19 Feb 2002, Jakob Kemi wrote:
> >
> > I also added three other hex-functions that can replace a lot of duplicated code.
> >
> > int  hexint_nibble (char x);          // hex digit to int.
> > int  hexint_byte  (const char *src); // hex digit-pair to int.
> > char inthex_nibble (int x);           // int to hex digit.
> > void inthex_byte   (int x, char* dest);       // int to hex digit pair.
> 
> Is there any reason to do all of this?
> 
> I suspect 99% of all users can (and probably should) be replaced with
> "sscanf()" instead. Which does a lot more, of course, and is not the
> fastest thing out there due to that, but anybody who does hex->int
> conversion inside some critical loop is just crazy.
> 
>                 Linus
> 

So maybe a wrapper or two:

#define hexint_nibble(x) {int y; sscanf(&x,"%1xl",&y); y}
#define hexint_byte(x)   {int y; sscanf(x,"%2xl",&y); y}

#define inthex_nibble(x) {char y[2]; sprintf(&y,"%1x",x); y[1]}
#define inthex_byte(x,dest)       sprintf(dest,"%02x",x)

Untested, of course.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/

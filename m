Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280508AbRKDSmQ>; Sun, 4 Nov 2001 13:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280377AbRKDSlJ>; Sun, 4 Nov 2001 13:41:09 -0500
Received: from unthought.net ([212.97.129.24]:50648 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281124AbRKDSjl>;
	Sun, 4 Nov 2001 13:39:41 -0500
Date: Sun, 4 Nov 2001 19:39:38 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104193938.H14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <20011104184159.E14001@unthought.net> <160RwJ-2D3EHoC@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160RwJ-2D3EHoC@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 07:27:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:27:16PM +0100, Tim Jansen wrote:
> On Sunday 04 November 2001 18:41, you wrote:
> > The "fuzzy parsing" userland has to do today to get useful information
> > out of many proc files today is not nice at all. 
> 
> I agree, but you dont need a binary format to achieve this. A WELL-DEFINED 
> format is sufficient. XML is one of them, one-value-files another one. The 
> "fuzzy parsing" only happens because the files try to be friendly for human 
> readers.

You need syntax or "transport", and then you need semantics.  My approach
is identical to XML except it doesn't give you kilobytes of human-unreadable
text.

You could use text, with binary you save the extra conversions along with
errors from parsers or bad use of sscanf()/sprintf()/...   K.I.S.S.   :)

I see a good point in using one-value-files though, except I think there's
some type information missing.

> 
> 
> > It eats CPU, it's error-prone, and all in all it's just "wrong".
> 
> How much of your CPU time is spent parsing /proc files?

[albatros:joe] $ time vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 113908   3184   1892 130584   1   1     3     3   61    43   9   5  86
 1  0  0 113908   3064   1896 130700   0   0     8     0 2301  1148   8   2  90
 0  0  0 113908   3064   1896 130700   0   0     0     0 2026   893   7   2  91
 0  0  0 113908   3064   1896 130700   0   0     0     0 1877   829   3   4  93
 0  0  0 113908   3068   1896 130696   0   0     0     0 1946   942   5   3  92
 0  0  0 113908   3072   1896 130696   0   0     0     0 2009  1034   7   5  88
 0  0  0 113908   3064   1896 130704   0   0     0     0 3706  2336   4   5  90
 0  0  0 113908   3064   1900 130688   0   0     0     0 2341  1671  10   3  87
 0  0  0 113908   3064   1900 130736   0   0     0     0 2431  1869  15   5  79
 2  0  0 113908   3064   1900 130764   0   0     0    88 2346  1440  12   3  85
^C

real	0m9.486s
user	0m0.070s
sys	0m0.120s

[albatros:joe] $ 


A *very* simple program (top is probably a lot worse!) uses 1% on my Dual 1.4
GHz Athlon.

Those TEN lines of status output cost me 336 MILLION clock cycles.

> 
> 
> > However - having a human-readable /proc that you can use directly with
> > cat, echo,  your scripts,  simple programs using read(), etc.   is
> > absolutely a *very* cool feature that I don't want to let go.  It is just
> > too damn practical.
> 
> You shouldn't use them in scripts because they are likely to break. That's 
> the whole point. At least not when you want to distribute the scripts to 
> others. And BTW the one-value-files are much easier to parse for scripts than 
> any other solution that I have seen so far, including the current /proc 
> interface.

I agree that there's some really good points in using single-value files.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

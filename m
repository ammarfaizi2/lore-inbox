Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270419AbRHMTT4>; Mon, 13 Aug 2001 15:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270429AbRHMTTq>; Mon, 13 Aug 2001 15:19:46 -0400
Received: from unthought.net ([212.97.129.24]:8146 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S270419AbRHMTT3>;
	Mon, 13 Aug 2001 15:19:29 -0400
Date: Mon, 13 Aug 2001 21:19:41 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Mircea Ciocan <mirceac@interplus.ro>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something that can be done against this ???
Message-ID: <20010813211941.C32620@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Mircea Ciocan <mirceac@interplus.ro>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E15WK98-0007gd-00@the-village.bc.nu> <3B7822E5.9AE35D4A@interplus.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3B7822E5.9AE35D4A@interplus.ro>; from mirceac@interplus.ro on Mon, Aug 13, 2001 at 09:56:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2001 at 09:56:37PM +0300, Mircea Ciocan wrote:
> 	The attached piece of script kiddie shit is the first one that worked
> flawlessly on my Mandrake box :((( ( kernel 2.4.7ac2, glibc-2.2.3 ),
> instant root access !!!.

Try echo "gotcha" > /etc/passwd

It will fail.

Because you don't have root - it just *looks* like it.

The "malicious" code is:
#include <stdio.h>
#include <stdlib.h>
int getuid() { return(0); }
int geteuid() { return(0); }
int getgid() { return(0); }
int getegid() { return(0); }
int getgroups(int size, int list[]) { list = (int *)malloc(sizeof(int)); return(1); }

The script spawns a new bash using LD_PRELOAD to override the glibc functions
with the above ones.

This does not compromise kernel security in any way what so ever.  Not even
close.  You *may* be able to trick a naive user, but he won't be able to do
anything bad, because he is not root.  Even though he may think he is.  And
even though bash may think it is.

> 	I was stunned, and it seem that is the beginning of a Linux Code Red
> lookalike worm :(((( using that exploit, probably this is not the most
> apropriate place to send this, but I'm not subscribed to the glibc
> mailing list and I just hope that some glibc hackers are on linux kernel
> list also and they see that and do something before we join the ranks of
> M$.
> 
> 		Dead worried,

Don't worry.

> 
> 		Mircea C.
> 
> P.S. Please tell me that I'm just being parnoid and that crap didn't
> work on your systems with a lookalike configuration.

You're just being paranoid and that crap didn't work on your system either  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

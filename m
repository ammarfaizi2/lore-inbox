Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbTAMBWx>; Sun, 12 Jan 2003 20:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTAMBWw>; Sun, 12 Jan 2003 20:22:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:19461 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267737AbTAMBWv>;
	Sun, 12 Jan 2003 20:22:51 -0500
Date: Mon, 13 Jan 2003 02:31:33 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Rob Wilkens <robw@optonline.net>
Cc: Willy Tarreau <willy@w.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? -> goto example
Message-ID: <20030113013133.GA31596@alpha.home.local>
References: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com> <1042404503.1208.95.camel@RobsPC.RobertWilkens.com> <20030112224829.GA29534@alpha.home.local> <1042419236.3162.257.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042419236.3162.257.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 07:53:57PM -0500, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 17:48, Willy Tarreau wrote:
> > Now, you asked for an example. Here is one. Please recode it without the
> 

[...]
> In fact, no where on the printed page did I
> see a closing parenthesis for your for.  Your giving me bad code to work
> from.
[...]
> The example you gave me wasn't valid C..
[...]

Well, first, I must say I've never seen such an arrogant beginner ! You even
felt the need to send me two posts, one private, then nearly the same one to
LKML. Poor guy, I gave you a piece of code to show you that your concepts were
wrong when applied to reality, and all you try to do is to gain street credit.
You will never learn because you whine before you think or search. Don't start
a code review of the kernel or you'll get lots of ennemies !

> Well, from what I can tell it wasn't valid C, because the "for" statement
> had an opening "(", but no visible closing ")" .. And the "{" looked like it
> was in the wrong spot.

>From what I can tell, you didn't even try to "info gcc" to check those wonderful
gcc extensions which allow a complex instruction block inside an expression.
The special construct ({ blabla }) is an expression which gets the value of the
last evaluated expression. Now I'm fedup with explaining to you how to access
basic information. Please unsubscribe, forget us and reboot under windows this
way (I'm sure you're already reading your mail as root) :

# lilo -u
# reboot

> If you want me to have something to benchmark against, I have to
> first be able to test and use your code, and if I can't use your code
> it's pointless to try to make it quicker.  

you'd need more code to be able to compile something. At least, I thought you
were smart enough to imagine how to rework it as you did on Linus' code, but
apparently I was wrong.

> If you could provide (preferrably via web download or ftp) sample source
> that uses that function, it would speed up my ability to benchmark,
> thereafter I could submit improved code.

I don't have all the parts of the code right at hand, and I don't know when/if
I'll send them. For the moment, just try to understand what I sent to you and
you can use this structure definition to understand better :

struct ultree {
    unsigned long low;          /* 32 bits low value of this node */
    unsigned long high;         /* 32 bits high value of this node, not used in 32 bits */
    int level;                  /* bit level of this node */
    void *data;                 /* carried data */
    struct ultree *left, *right;        /* children : left and right. NULL = leaf */
    struct ultree *up;          /* parent node. NULL = root */
};

Oh and if you have complaints about comments after the 80th column, remove them.
And if the order of the declaration doesn't match your habits, just know that
this is the order which gives me best performance, since swapping any 2 of its
members induces a loss of about 20%. You know, L1, cache line size... all the
things that your teachers didn't tell you because the story of the evil goto was
better to keep children quiet !

Bye,
Willy


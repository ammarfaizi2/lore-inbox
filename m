Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTDWAQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 20:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTDWAQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 20:16:32 -0400
Received: from fmr01.intel.com ([192.55.52.18]:13539 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263918AbTDWAQ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 20:16:28 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263BB9@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'karim@opersys.com'" <karim@opersys.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Tue, 22 Apr 2003 17:28:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Karim Yaghmour [mailto:karim@opersys.com]
> 
> The difference between copy_to_user() and memcpy() is not a
> minor detail. There is a reason why relayfs does its things the
> way it does.

Well, then I would like to ask you to help me understand what
is so radically different (aside from the might-sleep), because
I simply don't get it, and I am always willing to learn ..

> > That is a good point, that brought me yesterday night to the following
> > doubt. How do you guarantee integrity of the data when reading with
> > mmap. In other words, if I am just copying the mmap region, how do
> > I know that what I am copying is safe enough, that it is not being
> > modified by CPU #2, for example?
> [snip]
> 
> "Use the source, Luke."

Yep, see my last message to Tom, I am doing that - however, it is
pretty difficult to grasp things at the first try [specially when
you are kind of in a rush for many different things :)].

> OK, so you are suggesting we start making a difference in the kernel
> between those printks which are "optional" and those that are
> "compulsory"? Interested kernel developers are free to voice their
> interest at any time now ...

Where did I say that? I am not talking about printk() anywhere, 
btw, although if someone wants to do that, hey, it's their decision, 
isn't it? I am nobody's Mum as to tell them what to do and not 
to do.

OTOH, if someone would consider plugging printk to kue, I'd
consider kind of stupid to printk recallable messages ... if it
can be recalled, why print it at all?

I don't know why, but I have a feeling like you are taking all
this conversation too personal. It is not my intention to stomp
over all your work and criticize it. I am learning what you guys
have done, and yes, looking for defects or problems, because I
am concerned about things that don't match in my head and how
to solve them.

> > Now, if you want to make it resizable, that understands Japanese and
> > does double loops followed by a nose dive and a vertical climb up,
> > well, that's up to the client of the API. And I didn't want to
> > constraint the gymnastics that the client could do to handle a buffer.
> 
> Well, if we're talking about "double loops followed by a nose dive"
> we're certainly not going anywhere. I'll leave it to other LKML
> subscribers to decided wether automatically resizeable buffers are
> of interest.

Hey, where is your sense of humor?! Are you German, like my 
girlfriend? ;)

Automatically resizeable buffers are of *much* interest, to me at
least - remember that the only point I was stressing is I am leaving
that design/implementation issue out of the kue code, up to the 
client, while in relayfs it is inside of it.

I consider that a gain in kue's flexibility, while it is a gain 
in performance and space optimization on relayfs's hand (this is
my interpretation of Tom words in a previous mail and the code
I have had time to grasp; I think it makes full sense).

> > > I'm sorry, but the way I see printk() is that once I send something
> > > to it, it really ought to show up somewhere. Heck, I'm printk'ing
> > > it. If I plugged a device and the driver said "Your chair is
> > > on fire", I want to know about it whether the device has been
> > > unplugged later or not.
> >
> > I would say this case, printk(), would fit in my second example,
> > doesn't it? ... this is one message you want delivered, not recalled.
> 
> What I've been trying to say here is that there are no two kinds of
> printk. printk is printk and it ought to behave the same in all
> instances.

And I never said nowhere that it should not, in fact I have
stated clearly that printk's is something you shall not recall.
Twice, already ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

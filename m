Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVLYRYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVLYRYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 12:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVLYRYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 12:24:46 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:43475 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbVLYRYq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 12:24:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JesBC551aW3ZixaKrtWf/U0wCUsPiz6lhDoPraUJ11w7CAoYR2/vnQILYaCYHLEPZh8yjzhQClyrNxf0/thmHGtQ5Q8w0kN7O97zZoBWU50Am5tj0zVKquANW+GnmhZHmmPUK+K2qVbftW453MeZ+bGPxuFMjQwMMd8tmSO/3H0=
Message-ID: <1e62d1370512250924r4e3078d0ubb8986d52ac8aeb@mail.gmail.com>
Date: Sun, 25 Dec 2005 22:24:42 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Mateusz Berezecki <mateuszb@gmail.com>
Subject: Re: kernel list / container_of aka list_entry question
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-mentors@selenic.com
In-Reply-To: <aec8d6fc0512250850m4f8d4bd6y3772638d620548cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec8d6fc0512250850m4f8d4bd6y3772638d620548cd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/05, Mateusz Berezecki <mateuszb@gmail.com> wrote:
> I have two questions and I'll keep them short
>
> First one is about list_entry definition which is just a wrapper to
> container_of with exactly the same arguments (namely, ptr, type, member)
> whereas container_of is defined as follows
>
<snip>
> #define container_of(ptr, type, member) ({                      \
>         const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
>         (type *)( (char *)__mptr - offsetof(type,member) );})
>
>
> My question is why is there a '0' inside a definition?
>

The Statement ----> const typeof( ((type *)0)->member) *__mptr =
(ptr); is basically declaring a constant pointer of the data-type
exactly same as the member data-type  of the type (can be "struct foo"
let say) argument. For this by specifying ((type *)0)->member you
actually telling the compiler that at the address 0 my type (struct
foo) pointer is located and get me the member field of it and then my
typeof you are getting the typeof the member field. If you don't
specify (type *)0 then how you can tell the compiler to get the typeof
member field of the type (struct foo).

I hope you are will be able to get answer with my explanation.


> The second question is why the following code generates errors
> during compilation. list.h header file is included.
>
>         struct atheros_priv *priv = ieee80211_priv(dev); /* line number 141 */
>         struct list_head *iterator;
>
>
>         list_for_each(iterator, &priv->rxbuf.list) {
>                 struct ath_buf *bf = list_entry(iterator, (struct ath_buf), list);
>
>                 /* ... some operations on *bf here ... */
>         }
>
> and errors are as follows
>
>   CC [M]  /home/mb/atheros/transmit_receive.o
>   /home/mb/atheros/transmit_receive.c: In function 'ath_startrecv':
>   /home/mb/atheros/transmit_receive.c:141: error: syntax error before ')' token
>   /home/mb/atheros/transmit_receive.c:141: error: '__mptr' undeclared
> (first use in this function)
>   /home/mb/atheros/transmit_receive.c:141: error: (Each undeclared
> identifier is reported only once
>   /home/mb/atheros/transmit_receive.c:141: error: for each function it
> appears in.)
>   /home/mb/atheros/transmit_receive.c:141: error: syntax error before ';' token
>   /home/mb/atheros/transmit_receive.c:141: error: syntax error before ')' token
>   /home/mb/atheros/transmit_receive.c:141: error: syntax error before '(' token
>   /home/mb/atheros/transmit_receive.c:141: error: 'list' undeclared
> (first use in this function)
>   make[2]: *** [/home/mb/atheros/transmit_receive.o] Error 1
>
>

I just say that check your header files included, because I think the
.h file containing definition of struct ath_buf is not included and
the list_entry won't able to create __mptr pointer or so !

--
Fawad Lateef

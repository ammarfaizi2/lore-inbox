Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbRLGQkn>; Fri, 7 Dec 2001 11:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282905AbRLGQkh>; Fri, 7 Dec 2001 11:40:37 -0500
Received: from ns.ithnet.com ([217.64.64.10]:9487 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282902AbRLGQkY>;
	Fri, 7 Dec 2001 11:40:24 -0500
Date: Fri, 7 Dec 2001 17:39:54 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: m.luca@iname.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.17-pre5 / Have fun with make
Message-Id: <20011207173954.56896684.skraw@ithnet.com>
In-Reply-To: <32470.1007732114@ocs3.intra.ocs.com.au>
In-Reply-To: <20011207125530.40a13b87.skraw@ithnet.com>
	<32470.1007732114@ocs3.intra.ocs.com.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2001 00:35:14 +1100
Keith Owens <kaos@ocs.com.au> wrote:
> 
> CFLAGS_foo.o += -DMAX_CARDS=$(subst (,,$(subst ),,$(CONFIG_HISAX_MAX_CARDS)))
> 
> In foo.c, use MAX_CARDS instead of CONFIG_HISAX_MAX_CARDS.  Change foo
> to the name of the object that you are working on.  When you build, it
> should say -DMAX_CARDS=8.

Keith, it is getting weird right now. Your above suggestion does not work, it
does not even execute, because the braces obviously confuse it.
Now I come up with a _working_ solution, but to be honest, I don't dare to give
away the patch, because it looks like this:

EXTRA_CFLAGS      += -DHISAX_MAX_CARDS=$(subst ,,$(CONFIG_HISAX_MAX_CARDS))

You read it right, no substition is going on. BUT my test shows this executes
to e.g. "8" and not "(8)". This is what I wanted, but it looks like bs.
Alan would you please tell me if this looks like clean make usage to you, or
how you would drop "()" around integer definitions coming from CONFIG. Warning:
if you think this is ok, I will send the patch ;-) I only want a confirmation
from "Mr. Clean Code" ;-))

Regards,
Stephan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285608AbRLGWWX>; Fri, 7 Dec 2001 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285610AbRLGWWO>; Fri, 7 Dec 2001 17:22:14 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26886 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285606AbRLGWVu>;
	Fri, 7 Dec 2001 17:21:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: m.luca@iname.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.17-pre5 / Have fun with make 
In-Reply-To: Your message of "Fri, 07 Dec 2001 17:39:54 BST."
             <20011207173954.56896684.skraw@ithnet.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 09:21:36 +1100
Message-ID: <3323.1007763696@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 17:39:54 +0100, 
Stephan von Krawczynski <skraw@ithnet.com> wrote:
>On Sat, 08 Dec 2001 00:35:14 +1100
>Keith Owens <kaos@ocs.com.au> wrote:
>> 
>> CFLAGS_foo.o += -DMAX_CARDS=$(subst (,,$(subst ),,$(CONFIG_HISAX_MAX_CARDS)))
>> 
>> In foo.c, use MAX_CARDS instead of CONFIG_HISAX_MAX_CARDS.  Change foo
>> to the name of the object that you are working on.  When you build, it
>> should say -DMAX_CARDS=8.
>
>Keith, it is getting weird right now. Your above suggestion does not work, it
>does not even execute, because the braces obviously confuse it.

That's what I get for typing code late at night and not testing it.
The correct implementation of that line is probably

lp:=(
rp:=)

CFLAGS_foo.o += -DMAX_CARDS=$(subst $(lp),,$(subst $(rp),,$(CONFIG_HISAX_MAX_CARDS)))

But as you found, you don't need that anyway.

>Now I come up with a _working_ solution, but to be honest, I don't dare to give
>away the patch, because it looks like this:
>
>EXTRA_CFLAGS      += -DHISAX_MAX_CARDS=$(subst ,,$(CONFIG_HISAX_MAX_CARDS))

EXTRA_CFLAGS += -DHISAX_MAX_CARDS=$(CONFIG_HISAX_MAX_CARDS)

will work just as well.  The reason that you do not get '(8)' that way
is because CML1 generates inconsistent output.  In .config the line
says CONFIG_HISAX_MAX_CARDS=8, in include/linux/autoconf.h it says
#define CONFIG_HISAX_MAX_CARDS (8).  The makefiles use .config, the
source code uses autoconf.h.

Inconsistency of inconsistencies, saith the preacher; all is inconsistency.


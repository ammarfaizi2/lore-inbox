Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRLGNf4>; Fri, 7 Dec 2001 08:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLGNfb>; Fri, 7 Dec 2001 08:35:31 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:29188 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279981AbRLGNf1>;
	Fri, 7 Dec 2001 08:35:27 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: m.luca@iname.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Fri, 07 Dec 2001 12:55:30 BST."
             <20011207125530.40a13b87.skraw@ithnet.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 00:35:14 +1100
Message-ID: <32470.1007732114@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 12:55:30 +0100, 
Stephan von Krawczynski <skraw@ithnet.com> wrote:
>There is a problem: I made a (really small) patch to Config.in saying:
>
>   int  '  Maximum number of cards supported by HiSax' CONFIG_HISAX_MAX_CARDS 8
>
>If I check this in the source, it gives me CONFIG_HISAX_MAX_CARDS as (8)

Yuck!  CML1 outputs integers as #define CONFIG_foo (number) instead of
just number.  CML2 does not do that, I was looking at CML2.  Add this
to drivers/isdn/Makefile

CFLAGS_foo.o += -DMAX_CARDS=$(subst (,,$(subst ),,$(CONFIG_HISAX_MAX_CARDS)))

In foo.c, use MAX_CARDS instead of CONFIG_HISAX_MAX_CARDS.  Change foo
to the name of the object that you are working on.  When you build, it
should say -DMAX_CARDS=8.


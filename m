Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281541AbRLGO0E>; Fri, 7 Dec 2001 09:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281609AbRLGOZu>; Fri, 7 Dec 2001 09:25:50 -0500
Received: from ns.ithnet.com ([217.64.64.10]:53510 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281541AbRLGOZh>;
	Fri, 7 Dec 2001 09:25:37 -0500
Date: Fri, 7 Dec 2001 15:25:11 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: m.luca@iname.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre5
Message-Id: <20011207152511.178ff974.skraw@ithnet.com>
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

> On Fri, 7 Dec 2001 12:55:30 +0100, 
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> >There is a problem: I made a (really small) patch to Config.in saying:
> >
> >   int  '  Maximum number of cards supported by HiSax'
CONFIG_HISAX_MAX_CARDS 8
> >
> >If I check this in the source, it gives me CONFIG_HISAX_MAX_CARDS as (8)
> 
> Yuck!  CML1 outputs integers as #define CONFIG_foo (number) instead of
> just number.  CML2 does not do that, I was looking at CML2.  Add this
> to drivers/isdn/Makefile
> 
> CFLAGS_foo.o += -DMAX_CARDS=$(subst (,,$(subst ),,$(CONFIG_HISAX_MAX_CARDS)))
> 
> In foo.c, use MAX_CARDS instead of CONFIG_HISAX_MAX_CARDS.  Change foo
> to the name of the object that you are working on.  When you build, it
> should say -DMAX_CARDS=8.

Thanks for this hint, but it is not all that easy. Problem is the definition is
needed for _all_ files in the hisax-subtree, to be more precise for all
currently including hisax.h. I am not very fond of the idea to add additional
conditions to the availability of the HISAX_MAX_CARDS symbol, especially if
they are located in the Makefile. 
Anyway, how would you generate this additional -D for all files inside a
certain directory? Obviously the stuff should at least be put inside the
hisax-Makefile, and not one layer above in isdn-Makefile.

I tried "CFLAGS += ..." but that does not work.

Thanks for help,
Stephan


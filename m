Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDFHp0>; Fri, 6 Apr 2001 03:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRDFHpR>; Fri, 6 Apr 2001 03:45:17 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:35463
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S131344AbRDFHpC>; Fri, 6 Apr 2001 03:45:02 -0400
Message-ID: <3ACD73E0.2B1DFF6F@math.ethz.ch>
Date: Fri, 06 Apr 2001 09:44:32 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.75C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: johan.adolfsson@axis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Arch specific/multiple Configure.help files?
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no> <3ACD68FF.637D8958@math.ethz.ch> <018001c0be69$90dcb200$9db270d5@homeip.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johan.adolfsson@axis.com wrote:
> 
> > This was already discussed on kbuild list.
> > It is better to have only 1 Configure.help. This help
> > translation of the file and help busy developers.
> > They should not rewrite texts in every Configure.help.
> 
> I can't see that 1 file makes it easier.
> The same help text is only present in one file,
> either arch/$ARCH/Configure.help or
> Documentation/Configure.help

Ok, if you use both files.

Better a single file because:
- I18n support. (But not a big issue for us).
- CML2 merges all arch configurations in one file (really in 4
file:
  rules, menu strings, ...)
  Thus because we merge also configuration, I think that it is
better
  not to split the helps.
- IIRC there is only few ARCH specific configuration, thus we
don't
  reduce the size of che Configure.help
  Note that the arch/config.in have to much configuration item
  (but they repeat in (nearly) all arch/config.in files, thus
you
  should count only the really arch specific item.


I would prefer to have config.in and help file togheter. But
in the
discussion in kbuild list, it come that is is better to merge
all configuration in one file and the strings in an other (and
thus
not to merge Configure.help to not heve a very huge file).


What are the advanteget to split the Configure.help?

> 
> The help system first checks the file in arch/$ARCH and if
> the help is not present there it checks the one in Documentation/
> 


> > If you should provide a special help on a specific ARCH you
> > could modify the symbols: instead of
> > : bool 'std IPC support' CONFIG_IPC
> > you can do:
> > : bool 'arch specific IPC help' CONFIG_IPC_STRANGE_ARCH
> > : define_bool CONFIG_IPC CONFIG_IPC_STRANGE_ARCH
> 
> Don't know if you missunderstood me or if I missunderstand
> you here.
> The typical use for the arch specific help file would only cover
> the arch specific CONFIG options (although it could "override"
> the general help text in Documentation/Configure.help with
> an arch specific one, but if you do that I guess you're doing
> something wrong)

I think I missunderstood you. But this was the big issue for
splitting Configure.help. (Thus if an developer should use
at arch specific help, he should use this method)

> 
> > ESR CML2 have the defualt path for Configure.help build in
> > the rules files, but it can be overriden by command options
> > to use an other Configure.help (the format do not change).
> 
> I want to be able to use two help files.

I think it is not a big issue. In Makefile we can
: cat Conf.help.1 Conf.help2 > .Conf.help


	giacomo

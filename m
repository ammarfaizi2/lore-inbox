Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRDFJLQ>; Fri, 6 Apr 2001 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRDFJLG>; Fri, 6 Apr 2001 05:11:06 -0400
Received: from mail.axisinc.com ([193.13.178.2]:16658 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S131376AbRDFJKx>;
	Fri, 6 Apr 2001 05:10:53 -0400
Message-ID: <19da01c0be78$f9106c90$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <cate@debian.org>, <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.ggqkpgv.9g0c0b@ifi.uio.no> <fa.k6fq96v.nhaq06@ifi.uio.no> <3ACD68FF.637D8958@math.ethz.ch> <018001c0be69$90dcb200$9db270d5@homeip.net> <3ACD73E0.2B1DFF6F@math.ethz.ch>
Subject: Re: Arch specific/multiple Configure.help files?
Date: Fri, 6 Apr 2001 11:07:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: Giacomo Catenazzi <cate@math.ethz.ch>
To: <johana@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, April 06, 2001 09:44
Subject: Re: Arch specific/multiple Configure.help files?


> johan.adolfsson@axis.com wrote:
> > 
> > > This was already discussed on kbuild list.
> > > It is better to have only 1 Configure.help. This help
> > > translation of the file and help busy developers.
> > > They should not rewrite texts in every Configure.help.
> > 
> > I can't see that 1 file makes it easier.
> > The same help text is only present in one file,
> > either arch/$ARCH/Configure.help or
> > Documentation/Configure.help
> 
> Ok, if you use both files.
> 
> Better a single file because:
> - I18n support. (But not a big issue for us).
I must admit that I haven't got a clue what that is:-)

> - CML2 merges all arch configurations in one file (really in 4
> file:
>   rules, menu strings, ...)
>   Thus because we merge also configuration, I think that it is
> better not to split the helps.

If this is solved by merging two files or if the config system
really uses two files doesn't really matter to me.
Merging files is probably a better approach if having
non-centralised help files can be accepted.

> - IIRC there is only few ARCH specific configuration, thus we
> don't
>   reduce the size of che Configure.help
>   Note that the arch/config.in have to much configuration item
>   (but they repeat in (nearly) all arch/config.in files, thus
> you
>   should count only the really arch specific item.

Here are some results: 
$ wc arch/cris/Configure.help 
    621    4424   28373 arch/cris/Configure.help
$ wc Documentation/Configure.help 
  17480  121037  773694 Documentation/Configure.help
$ grep CONFIG arch/cris/Configure.help |wc
     75     138    2337
$ grep CONFIG Documentation/Configure.help |wc
   1486    1640   30135

it's not entiraly correct since the CONFIG_BLUETOOTH help
is in the arch/cris directory and that should probably be in
Documentation/ or in the OpenBT package and merged from there.
The file also contains the # LocalWords: rows from the original
Configure.help.

But the ETRAX/CRIS config is 3-5% of the total config.
 
Having the help close to the config sounds like a good idea
from a maintenance point of view.

> I would prefer to have config.in and help file togheter. But
> in the
> discussion in kbuild list, it come that is is better to merge
> all configuration in one file and the strings in an other (and
> thus
> not to merge Configure.help to not heve a very huge file).
> 
> 
> What are the advanteget to split the Configure.help?
> 
> > 
> > The help system first checks the file in arch/$ARCH and if
> > the help is not present there it checks the one in Documentation/
> > 
> 
> 
> > > If you should provide a special help on a specific ARCH you
> > > could modify the symbols: instead of
> > > : bool 'std IPC support' CONFIG_IPC
> > > you can do:
> > > : bool 'arch specific IPC help' CONFIG_IPC_STRANGE_ARCH
> > > : define_bool CONFIG_IPC CONFIG_IPC_STRANGE_ARCH
> > 
> > Don't know if you missunderstood me or if I missunderstand
> > you here.
> > The typical use for the arch specific help file would only cover
> > the arch specific CONFIG options (although it could "override"
> > the general help text in Documentation/Configure.help with
> > an arch specific one, but if you do that I guess you're doing
> > something wrong)
> 
> I think I missunderstood you. But this was the big issue for
> splitting Configure.help. (Thus if an developer should use
> at arch specific help, he should use this method)
> 
> > 
> > > ESR CML2 have the defualt path for Configure.help build in
> > > the rules files, but it can be overriden by command options
> > > to use an other Configure.help (the format do not change).
> > 
> > I want to be able to use two help files.
> 
> I think it is not a big issue. In Makefile we can
> : cat Conf.help.1 Conf.help2 > .Conf.help

Sounds better than dealing with two different help files in the
config system.
Is there an ETA when ESR CML2 will be in the official kernel?
(I guess I should catch up on what it will provide instead of
 wasting peoples time...)

Would adding support for merging help files in the current config 
system be accepted in the meanwhile?
E.g. Configure, Menuconfig and header.tk is changed to use
Documentation/Configure.help.generated
and the top Makefile does
cat $(HELPFILES) >Documentation/Configure.help.generated 2>/dev/null
for oldconfig, config, menuconfig and xconfig targets?
And HELPFILES is set to:
HELPFILES = arch/$(ARCH)/Configure.help Documentation/Configure.help

External patches that add functionality could easaly add 
HELPFILES += some new help files 
rows to get the help as well.

> giacomo

/Johan



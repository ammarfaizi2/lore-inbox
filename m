Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292428AbSBUPGW>; Thu, 21 Feb 2002 10:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292429AbSBUPGQ>; Thu, 21 Feb 2002 10:06:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29702 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292437AbSBUPFy>;
	Thu, 21 Feb 2002 10:05:54 -0500
Message-ID: <3C750CCF.989B1FDD@mandrakesoft.com>
Date: Thu, 21 Feb 2002 10:05:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.44.0202210636020.8696-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> On Thu, 21 Feb 2002, Jeff Garzik wrote:
> 
> > David Lang wrote:
> > > 1. does this handle the cross directory dependancies?
> >
> > I presume you are talking about Roman's tool, so I'll let him answer.  I
> > think he just implemented a converter to a new language, so new language
> > tools to parse the language don't exist yet, I think.
> 
> I am so I'll wait for his answer
> 
> > > 2. does it handle the 'I want this feature, turn on everything I need for
> > > it'?
> >
> > This is fundamentally impossible for anything beyond the most simple
> > features. Although you can do a lot with config.in info, "everything I
> > need" is something a human needs to define in many cases.
> >
> 
> unless I am missing something this is one of the features that CML2
> implements. Agreed that 'everything I need' needs to be defined by a
> human, that's what Eric has done in his ruleset, define the dependancies.

Even within the constraints of CML1, you can do stuff like "I want
CONFIG_USB_HID, which implies that CONFIG_INPUT is needed"

That simple stuff.  For anything beyond that, like "create me an
ipv6-netlink configuration with adequate support for 3rd party modules"
it's not gonna cut it, nor will any reasonable config system.

> > > 3. if it handles #2 what does it do if you turn off that feature again
> > > (CML2 turns off anything it turned on to support that feature, assuming
> > > nothing else needs it)
> >
> > This is a policy decision.  I'm not sure one -wants- to do this...
> > Doing something like this blindly can have unintended side effects, i.e.
> > violate the Principle of Least Surprise.
> 
> I'll argue that _not_ doing this violated the principle of lease surprise,
> if you turn a feature on and immediatly back off why should anything in
> your config be any different then it was before you turned it on?

It sounds like you want an implementation detail -- undo last [n]
choice[s].

Imagine this case:

make xconfig # select CONFIG_USB_HID, which auto-selects CONFIG_INPUT
{ time passes }
make xconfig # de-select CONFIG_USB_HID

On the second 'make xconfig', should CONFIG_INPUT be automatically
de-selected?  No.  Because that is making the assumption that the person
does not want to continue to make the input API available.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"

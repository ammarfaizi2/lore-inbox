Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288966AbSANTKy>; Mon, 14 Jan 2002 14:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSANTJw>; Mon, 14 Jan 2002 14:09:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35797 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288932AbSANTJS>;
	Mon, 14 Jan 2002 14:09:18 -0500
Date: Mon, 14 Jan 2002 14:09:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114131050.E14747@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > For 2.5 if things go to plan there will be no such thing as a "compiled in"
> > driver. They simply are not needed with initramfs holding what were once the
> > "compiled in" modules.
> 
> This is something of a bombshell.  Not necessarily a bad one, but...
> 
> Alan, do you have *any* *freakin'* *idea* how much more complicated
> the CML2 deduction engine had to be because the basic logical entity
> was a tristate rather than a bool?  If this plan goes through, I'm
> going to be able to drop out at least 20% of the code, with most of
> that 20% being in the nasty complicated bits where the maintainability
> improvement will be greatest.  And I can get rid of the nasty "vitality"
> flag, which probably the worst wart on the language.
> 
> Yowza...so how soon is this supposed to happen?

Two technical obstacles:
	a) on some architecures modular code is slower (IIRC, the problem is
with medium-range calls being faster than far ones and usable only in the
kernel proper).  We probaly want to leave a gap after the .text and remap
.text of module in there - if I understand the problem that should be
enough, but that's really a question to folks dealing with these ports (PPC64
and Itanic?)
	b) current differences between options parsing in case of built-in
and modular drivers.

The rest is trivial and should be done in 2.5.4-pre* or so.

But it still leaves you with tristate - instead of yes/module/no it's
yes/yes, but don't put it on initramfs/no.  However, dependencies become
simpler - all you need is "I want this, that and that on initramfs" and
the rest can be found by depmod (i.e. configurator doesn't have to deal
with "FOO goes on initramfs (== old Y), so BAR and BAZ must go there
(== can't be M)").


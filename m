Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289955AbSAPDpd>; Tue, 15 Jan 2002 22:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290256AbSAPDpT>; Tue, 15 Jan 2002 22:45:19 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:18112 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290068AbSAPDls>; Tue, 15 Jan 2002 22:41:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, Anton Altaparmakov <aia21@cus.cam.ac.uk>
Subject: Re: CML2-2.1.3 is available
Date: Tue, 15 Jan 2002 14:30:28 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020115145324.A5772@thyrsus.com> <Pine.SOL.3.96.1020115201156.26402C-100000@libra.cus.cam.ac.uk> <20020115152445.B6308@thyrsus.com>
In-Reply-To: <20020115152445.B6308@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116034147.CRIZ26021.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 03:24 pm, Eric S. Raymond wrote:

> To invoke the autoconfigurator, you do one of two things:
>
> `make autoconfigure'
>     This runs the autoconfigurator in standalone mode.  This gives you
> an entire configuration, ready to build with.
>
> `make autoprobe {config,menuconfig,xconfig}'
>     This runs the autoconfigurator in probe mode, which gives you
> a report on facilities found (without making assumptions about facilities
> not found).  This report gets fed to your interactive configurator, which
> then proceeds not to bother you with questions for which the autoprobe
> report already gave it answers.
>
> The ordinary make {config,menuconfig,xconfig} behaves as it always did.

Eric and I disagree on the behavior of "make autoprobe".  He likes the 
concept of "freezing" symbols, which says if the autoprober detected a 
configuration setting, the question shouldn't show up and give you the 
opportunity to disagree.  (Not confusing Aunt Tillie, with her LCSE from 
CompTIA (and apparently has recently moved in with Alan Cox), with questions 
that she's more likely to screw up than improve.)

Personally, I think that if you turn on "expert" mode, you should be able to 
override anything.  I haven't complained much because there is an easy 
workaround: Although the autoprober puts the "frozen" flag on the symbols it 
finds, menuconfig doesn't save them out :).  So just run menuconfig twice and 
you can edit everything that got autoprobed...

The user interface still has a couple of teething troubles, but they're 
mostly in the new stuff that CML1 never attempted to do (like autoconfig).

(Now the standard configuration DOES freeze, and therefore hide, the "which 
architecture am I building for" question.  It would be nice if "make 
menuconfig" would let you do a cross-compile simply by selecting your 
architecture.  I understand why this isn't supported though: to properly 
build most architectures other than X86, you have to apply patches to Linus's 
tree.  And the make would have to tell gcc to cross-compile, which most gcc 
builds don't know how to do and the makefiles don't seem to support 
anyway...)

Rob


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbRDSEuC>; Thu, 19 Apr 2001 00:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbRDSEto>; Thu, 19 Apr 2001 00:49:44 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:52988 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135548AbRDSEtW>; Thu, 19 Apr 2001 00:49:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104190449.f3J4n2LF032522@webber.adilger.int>
Subject: Re: Cross-referencing frenzy
In-Reply-To: <20010418233445.A28628@thyrsus.com> "from Eric S. Raymond at Apr
 18, 2001 11:34:45 pm"
To: esr@thyrsus.com
Date: Wed, 18 Apr 2001 22:49:01 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric writes:
> So.  I've written a cross-reference analyzer for the configuration symbol
> namespace.  It's included with CML 1.2.0, which I just released.  The
> main reason I wrote it was to detect broken symbols.
> 
> A symbol is non-broken when:
> 	* It is used in either code or a Makefile
> 	* It is set in a (CML1) configuration file
> 	* It is either derived from other non-broken symbols 
>           or described in Configure.help
> If it fails any one of these conditions, it's cruft that makes the kernel
> code harder to maintain and understand.  The least bad way to be broken is
> to be useful but not documented.  The most bad way is to lurk in code, doing
> nothing but making the code harder to understand and maintain.

Could you make a list that splits the symbols up by each of the above
failure conditions?  It would make the task of deciding how to fix the
"problem" more apparent.

Also, it appears that some of the symbols you are matching are only in
documentation (which isn't necessarily a bad thing).  I would start with:

*.[chS] Config.in Makefile Configure.help


However, I'm not sure that your reasoning for removing these is correct.
For example, one symbol that I saw was CONFIG_EXT2_CHECK, which is code
that used to be enabled in the kernel, but is currently #ifdef'd out with
the above symbol.  When Ted changed this, he wasn't sure whether we would
need the code again in the future.  I enable it sometimes when I'm doing
ext2 development, but it may not be worthy of a separate config option
that 99.9% of people will just be confused about.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

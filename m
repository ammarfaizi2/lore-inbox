Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSE3N2X>; Thu, 30 May 2002 09:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSE3N2W>; Thu, 30 May 2002 09:28:22 -0400
Received: from stingr.net ([212.193.32.15]:16054 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S316636AbSE3N2V>;
	Thu, 30 May 2002 09:28:21 -0400
Date: Thu, 30 May 2002 17:28:21 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Message-ID: <20020530132821.GO422@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E17DMUd-0007dJ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Daniel Phillips:

Thanks for numbers, Daniel. Maybe it will impress them much.

> I have only one point on the curve, but it confirms what Keith has
> been saying.  The incremental build speed is especially important to
> me.  If I were working all the time on 2.5 - sadly, I'm not - I would
> without question be using kbuild 2.5 simply by reason of the fast
> incremental builds.

I have almost complete kbuild25ified tree, 2.4.19-pre8-ac5 with addons, and
will make it available later today or earlier tomorrow.

> Note to anyone who wants to try this themselves: with the kbuild 2.5
> patches applied, nothing changes (and the old build system is used)
> unless you add '-f Makefile-2.5' to the make command.  It does not
> appear to be necessary to supply a bzImage target, and in fact,
> Makefile-2.5 doesn't recognize it.  That's basically all you have to
> know.

It is IMO needed to add here:

- kb25 makefile.in syntax is much cleaner and don't require to contain
  extra crap, .in files are better maintainable for patch systems like
  netfilter p-o-m. and another one - $(c_to_o) definition allows us to
  reduce size of makefiles, and unnesessary handmerging of some patches.
- it is very stupid do appeal to codesize of Rules.make vs. kbuild25 core
  and discard kb25 based on this. Remember - efficient way is not always
  eq smaller code (one example is bubblesort vs. heapsort). Here, in fact,
  if we'll bloat Rules.make to 10k lines then we stuck due to make 
  stupidity^Wlimitations, but if we use 10k of C code to build a program 
  which (with many other things) give us ONE makefile of whole tree, we'll 
  gain here - we don't need to invoke make many times etc.
- it's not very efficient to try to improve rotten system when there is
  ready to use better replacement floating around

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288121AbSAQCcC>; Wed, 16 Jan 2002 21:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288117AbSAQCbx>; Wed, 16 Jan 2002 21:31:53 -0500
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:55457 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288112AbSAQCbg>; Wed, 16 Jan 2002 21:31:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Ross Vandegrift <ross@willow.seitz.com>,
        "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Date: Wed, 16 Jan 2002 13:29:32 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020115145324.A5772@thyrsus.com> <20020115230211.A5177@thyrsus.com> <20020116113840.A16168@willow.seitz.com>
In-Reply-To: <20020116113840.A16168@willow.seitz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020117023135.GSHC21740.femail36.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 January 2002 11:38 am, Ross Vandegrift wrote:
>
> At this point the rules are compiled and a dialog box indicates that
> Suppression has been turned off (press any key to continue).  I hit any key
> and am presented with the first menu.

Ah, I understand the bug.

That dialog indicates that your existing .config (the one it loaded the 
symbols from) is setting a symbol that is ordinarily suppressed.  (One your 
dependency list thinks you shouldn't have access to, like a piece of 
Alpha-only hardware during an X86 configuration session.)

It found it, noticed that setting it would be inconsistent with the existing 
rulebase's dependencies, and let you know that it had to turn suppression off 
in order to access it.  That's not the bug (although it implies that either 
your .config is really weird, or there's a rulebase error suppressing 
something that shouldn't be).  It just triggers the bug.

Turning off suppression will also make frozen symbols show up, as you 
noticed.  This is where an old bug I already got Eric to patch resurfaced. :)

The "menu freezing" bug is a menuconfig display problem.  It happens because 
you can't select a frozen symbol: it skips to the next one when you cursor 
over it.  If EVERY symbol in the menu is frozen, when you first try to 
display the menu it goes into an endless loop trying to figure our what 
symbol to put the cursor on.

I told Eric about this earlier, and he hid all the frozen symbols (which he 
intended to do anyway).  A menu with no visible symbols won't show up.

But when you turn off suppression, the menu gets unhidden, and the bug comes 
back.

Eric, you wanna take another swing at it?

Rob

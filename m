Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSIOXTW>; Sun, 15 Sep 2002 19:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSIOXTW>; Sun, 15 Sep 2002 19:19:22 -0400
Received: from bitmover.com ([192.132.92.2]:12975 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S318293AbSIOXTU>;
	Sun, 15 Sep 2002 19:19:20 -0400
Date: Sun, 15 Sep 2002 16:24:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915162412.A17345@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Brownell <david-b@pacbell.net>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <E17qRfU-0001qz-00@starship> <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <20020915190435.GA19821@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020915190435.GA19821@nevyn.them.org>; from dan@debian.org on Sun, Sep 15, 2002 at 03:04:35PM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 03:04:35PM -0400, Daniel Jacobowitz wrote:
> Tracking this bug down took me about six hours.  Someone more familiar
> with that particular segment of code could, I assume, have done it more
> quickly.  One advantage of a debugger is that it's easier to look at

I'm not speaking for Linus, but I wouldn't be surprised we share the 
same view on this one.  As someone who maintains a fairly large source
base I get nervous when people tell me they need a debugger to work on
the code.  Why?  Because if you really need that it is EXTREMELY likely
that you don't understand the code.  If you don't understand the code
then YOU SHOULDN'T BE CHANGING IT.  It is infuriating to have a section
of tricky code that used to work, you turn your back, only to find that
someone made a "simple change" which seems to work but actually makes
things worse and invariably seems to break the code in a far more
subtle way.  

My position is that you either understand the code or you don't.  Code
that you don't understand is read only.  Having a debugger show you some
variables isn't going to make you understand the code at the level which
is required in order to be making changes.

Does this mean I'm against debuggers?  Not at all.  But in 15 years of
doing kernel work and 5 years of doing BK work the only thing I've ever
used one for was to get a few variables printed out.  And I've written
a substantial chunk of a debugger years ago, it's not a question of lack
of debugger knowledge.  I just rarely find them useful.  

> Plus, in my experience the work model that BitKeeper encourages puts a
> significant penalty on including unrelated patches in the tree while
> you're debugging.  It can be gotten around but it's exceptionally
> awkward.  Adding in KGDB means time spent merging it into my tree and
> time spend merging it cleanly out when I'm done with it.

Create a throwaway clone, merge in kdb, tag the tree with "baseline".
Now hack away until you have a fix.  If you never checked anything in
after the baseline then "bk -r diffs -u" creates the patch for your
bugfix.  If you did, then diff against the baseline.

If BK is awkward by comparison to diff and patch, something is wrong, it
definitely has the ability to make things far more pleasant than you
seem to be experiencing.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

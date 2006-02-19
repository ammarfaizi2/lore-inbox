Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWBSLsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWBSLsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 06:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBSLsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 06:48:52 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:15512 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S932401AbWBSLsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 06:48:52 -0500
Date: Sun, 19 Feb 2006 12:47:36 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: Thomas Dickey <dickey@his.com>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, torvalds@osdl.org,
       bug-ncurses@gnu.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
Message-ID: <20060219114736.GD862@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru> <20060218204407.L36972@mail101.his.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060218204407.L36972@mail101.his.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 08:53:38PM -0500, Thomas Dickey wrote:
> More to the point: since it's been in this form for several years, it 
> doesn't do much good to developers, because there are already workarounds 
> in ncurses to accommodate this, and even if you fixed it today, it would
> be needed in ncurses for a few more years.
> 
> For example (man ncurses):
> 
>        NCURSES_NO_UTF8_ACS
> ...
>             for Linux and screen.
> 
> is the most recent refinement (from a year ago) to a workaround which 
> first appeared in ncurses 5.4 (originally from December 2002).

OK but my fix is for all not only curses programs. Anyway from my point of view
programs should be written in a way so they are easy to use and work correctly
without user special intervention and knowledge. So ncurses hack is not
a desired way IMHO. Generally saying products should be designed with customers
comfort and not developers/producers comfort in mind. But this is just a wish
of course in current world and off topic.

> >This disagreement has to be solved somehow.
> 
> yes.  ncurses has no better information for this than the result from
> wcwidth().  Shall we add another kludge to accommodate Linux console?
> (Are there other terminal emulators with this specific problem?)

If ncurses know that this is a two-columns wide character so for compatibility
and correct handling reasons kernel console driver should know it too
and send two replacement glyphs or better one replacement glyph and one space 
or there should be n column replacement glyph implemented
(maybe as a replacement glyph and n-1 additional spaces) as for example putty
xterm-color terminal emulator does.

For correct selecting and pasting from console in UTF-8 mode without
data corruption in case of non displayed glyphs and malformed sequences
console screen contents should be memorized as UCS-2 wide chars plus additional
attributes and color information.

Also there should be some specification - maybe RFC - how correctly handle
UTF-8 malformed seqences so no information is corrupt during
displaying/cut/paste/edit operations. If user edits then it should be changed
but if there is no action there should be no change.
So automatic recoding or not displaying something leads to state when I could
have inproper file name and just can't correct it from command line because
I can't input inproper sequence from keyboard - just like in MS Windows -
or I must use some additional software or graphical tool.

Additionally a replacement glyph means that a valid glyph can't be displayed
by a device which doesn't mean that the particular UTF-8 sequence is incorrect.
Of course an inproper byte can't be displayed too because we don't know
what it really means. Result is the same but reasons are different.
So showed on vt screen results hide real reasons which is bad IMHO.
But only the replacement glyph is defined in the standard and there is no bad
byte indicator which is really needed ;-(.

Regards
-- 
Adam Tla³ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

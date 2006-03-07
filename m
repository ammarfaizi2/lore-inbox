Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWCGPGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWCGPGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWCGPGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:06:13 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:54725 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751142AbWCGPGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:06:12 -0500
Message-ID: <440DA141.9010906@pg.gda.pl>
Date: Tue, 07 Mar 2006 16:05:37 +0100
From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Thomas Dickey <dickey@his.com>
CC: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, torvalds@osdl.org,
       Ncurses Mailing List <bug-ncurses@gnu.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru> <20060218204407.L36972@mail101.his.com> <20060219114736.GD862@sunrise.pg.gda.pl> <20060219201811.D62691@mail101.his.com>
In-Reply-To: <20060219201811.D62691@mail101.his.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dickey wrote:

> On Sun, 19 Feb 2006, Adam Tla/lka wrote:
>
>> OK but my fix is for all not only curses programs. Anyway from my
>> point of view programs should be written in a way so they are easy to
>> use and work correctly without user special intervention and
>> knowledge. So ncurses hack is not
>
>
> of course (which is why I have xterm doing the same thing).

Yes, I tested VT100 graphics in UTF8-mode with  various terminal
emulator programs - xterm, gnome-terminal, kconsole, mlterm, rxvt - and
they all work the same way accepting ^N as smacs and VT100 graphics
chars. So this is the reason why Linux console should not break this
compatibility in UTF8 mode too.

There are some programs which use ascs even if they can do it by UTF8
sequences - w3m for example. Without supporting
acsc in UTF8 mode using Linux console and w3m gives not so good visual
results. Second reason ;-).
There are other programs of course - aptitude for example - working the
same way as w3m.

Using smacs=\e[11m which means smacs == smpch is some kind of a hack and
not the proper solution. Terminal description should describe sequences
interpreted by a device and in case of smacs == smpch sequences like ^N
and ^O do not exist in terminal description but they are interpreted as
before. So the description is not complete. The acsc string should be
set so it sticks to VT100 map in Linux console sources too:

acsc=++\,\,--..00``aaffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~

now adding proper USC2 to font mapping to used console font makes it
working correctly in both normal and UTF8 modes. Other solutions like
modifying acsc to obtain some different chars for nonexisting glyphs are
only partially correct because we have only half functioning terminal -
in normal mode we see some chars but in UTF8  mode there are only
replacemnt glyphs. So only the compatible definition and then correction
to console fonts included UCS2 to glyph maps solves the problem IMHO.
Also if we have different definitions on different systems and VT100
compatibility is lost we have problems too.

After some discussion I've  sended final patch

2006-02-27 13:06 [PATCH]console compatibility fixes to UTF-8 mode

and now I am waiting for some reaction.
I am using this patch with my work machines now.

Regards

-- 
Adam Tlałka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group       - - - ~~~~~~
Computer Center,  Gdańsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTI1To4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTI1To4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:44:56 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49284 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262694AbTI1Toy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:44:54 -0400
Date: Sun, 28 Sep 2003 20:44:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928194405.GA17235@mail.jlokier.co.uk>
References: <20030928184642.GA1681@mars.ravnborg.org> <Pine.LNX.4.44.0309281150240.15408-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309281150240.15408-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 28 Sep 2003, Sam Ravnborg wrote:
> > Would it help to require all major[1] header files to include all the
> > header files needed for them to compile?
> 
> It causes tons of extra work for the compiler if the compiler doesn't 
> optimize away redundant header files (same header file being included from 
> a lot of different sources).
>
> I did the pruning in sparse, and I think at least gcc-3 does it too, but 
> I'm not sure.

GCC does optimise away multiple header file inclusion, and has done
for a very long time, oh a decade or so :)

GCC will not reparse a header file if these conditions are met:

	1. The file has already been parsed at least once.

	2. Apart from comments, the entire file is surrounded by
	   "#ifndef symbol ... #endif" or "#if !defined (symbol) ... #endif".

	3. "symbol" is defined.

	4. The file names are the same after removal of "." and ".." components
	   and other path simplifications.

> If so, then sure, we could just require that the header files compile 
> cleanly, and for extra points verify that the end result is an empty 
> object file (ie no bad declarations anywhere..).

You can also use the "-H" option and check for a "Multiple include
guards may be useful for:" message, to check those #ifndefs.

-- Jamie

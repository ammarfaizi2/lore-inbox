Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUBQLHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 06:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUBQLHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 06:07:24 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:31244 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264855AbUBQLHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 06:07:22 -0500
Message-ID: <4031F8F9.4070909@aitel.hist.no>
Date: Tue, 17 Feb 2004 12:20:25 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	"pcg\"@goof(A.).(Lehmann )com\"" <pcg"@goof(A.).(Lehmann )com">
							     ^-illegal end of route address, missing end of address
CC: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de>
In-Reply-To: <20040217071448.GA8846@schmorp.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)

pcg( Marc)@goof(A.).(Lehmann )com wrote:
> On Mon, Feb 16, 2004 at 02:40:25PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>Try it with a regular C locale. Do a simple
>>
>>	echo > едц
> 
> 
> Just for your info, though. You can't even input these characters in a C
> locale, since your libc (and/or xlib) is unable to handle them (lots of SO
> C functions will barf on this one). C is 7 bit only.
> 
> 
>>Which, if you think about is, is 100% EXACTLY equivalent to what a UTF-8
>>program should do when it sees broken UTF-8.
> 
> 
> The problem is that the very common C language makes it a pain to use
> this in i18n programs. multibyte functions or iconv will no accept
> these, so programs wanting to do what you are expecting to do need to
> re-implement most if not all of the character handling of your typical
> libc.
> 
> Yes, it's possible....

All you need is a possible_garbage_to_properly_escaped_utf8(char *string)
in libc.  Any program that wants to display filenames it got
straight from readdir (or any binary file contents) will simple feed
the string through that and get back a string with
escapes for anything that isn't utf8.  It is a write-once, use
everywhere thing.

Once up on a time, there were serious problems when someone created
filenames like "; rm -fr *"  Today we use tab completion
and get bash to present the filename with proper escapes.  It is then harmless.
Bad utf8 can be handled the same way.

> The "bit" is enourmous, as you can't use your libc for text processing
> anymore.

Not the current libc, but libc can be improved upon. The same happened to
silly code that weren't 8-bit clean.

Helge Hafting


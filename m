Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265744AbUBPOMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUBPOMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:12:00 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:35208 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S265744AbUBPOD4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:03:56 -0500
Date: Mon, 16 Feb 2004 15:03:38 +0100
From: Eduard Bloch <edi@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216140338.GA2927@zombie.inka.de>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040215010150.GA3611@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailgate1.uni-kl.de id i1GE3sRL029935
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Jamie Lokier [Sun, Feb 15 2004, 01:01:50AM]:

> > Then you have something wrong in the shell configuration of the remote
> > machine. I do not see any problems in having a ssh shell opened from a
> > UTF-8 terminal to a machine where the shell environment is also
> > configured to use UTF-8 environment.
> 
> Of course that's fine.  What goes wrong is when you connect to that
> same machine from another terminal which is not UTF-8.
> 
> There are in fact two different problems, and you have ignored them both :)
> 
> Firstly, "ls", editors, filenames:
> 
>    The shell configuration is irrelevant.  If I create a file name
>    like "£100.txt" (that's POUND followed by "100.txt") when I'm

Sure, sure, I can read it since I use UTF-8 too.

>    connected from a UTF-8 terminal, it creates a filename encoded in
>    UTF-8 and displays it fine.
> 
>    If I then log in to the same machine from another terminal which
>    displays latin1, then "ls" will _not_ display the name correctly
>    _regardless_ of shell or locale configuration.

I know what you mean and that is why I already proposed a radical
solution. Let me repeat it:

 - convert all files from the previous charset to UTF-8 overnight
   if the previous charset was unknown, first make sure that you can
   guess it for all users and contact users that have files with
   suspicous filenames (eg. not convertable from Latin1). Or look trough
   their shell/X config files (*)
 
 - in libc, implement a recoding function to convert file names from
   LC_CTYPE to the underlying UTF-8 encoding

Done.

(*) There is no other way. Linux developers ignored the diversity of
charset/encodings over many years and now the needed information is lost
(not stored anywhere in the filesystem)

>    If I then create a file called "£100.txt" (same name) using the
>    terminal which displays latin1, it creates a filename encoded in
>    latin1.

Of course. That is what the conversion shoudl be done in Userspace
(libc). The kernel itself does not know about used locale.

>    Unfortunately, to be compatible with shell utilities, programs like
>    Mutt and Emacs which _are_ aware of the display and input encodings
>    will use the current terminal's encoding when accessing the

That is the correct way, though.

>    filesystem.  So even those programs create file names with the
>    wrong encoding, if you log in from the wrong kind of terminal.

It is the _right_ enconding in the moment when they create it.

> Secondly, message locale and the shell:
> 
>    There is no mechanism for SSH to convey which character encoding
>    the remote machine must use for displaying and inputting text, yet
>    client terminals come in different flavours.  That is the problem.
> 
>    (On my laptop, for example, which is a standard RH9, Gnome terminal
>    windows are UTF-8 but console is latin1).  These are both fine
>    locally.  There is no configuration on a remote machine which is right
>    for both of them, though.)

Yup, I know that problem. At least to display them correctly, you can
either run unicode_start (to enable console's own conversion) which
sucks when they are chars from completely different language groups, eg.
latin and cyrillic. I used dynafont for a while which worked well for
displaying characters.

>    I think this is because the character encoding used by the terminal
>    should be in the TERM environment variable, but it is in LANG instead.

No. TERM does not have anything to do with locales (LANG).

Regards,
Eduard.
-- 
Selbstlosigkeit ist ausgereifter Egoismus.
		-- Herbert Spencer

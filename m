Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUK0LJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUK0LJU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 06:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUK0LJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 06:09:20 -0500
Received: from [83.151.192.5] ([83.151.192.5]:21939 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S261186AbUK0LIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 06:08:53 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Christian Mayrhuber <christian.mayrhuber@gmx.net>
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200411262213.58242.christian.mayrhuber@gmx.net>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <1101379820.2838.15.camel@grape.st-and.ac.uk>
	 <41A773CD.6000802@namesys.com>
	 <200411262213.58242.christian.mayrhuber@gmx.net>
Content-Type: text/plain
Message-Id: <1101553779.3680.28.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 27 Nov 2004 11:09:41 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 21:13, Christian Mayrhuber wrote:
> Regarding namespace unification + XPath:
> For files: cat /etc/passwd/[. = "joe"] should work like in XPath.

I don't understand this. Why would you need the "."? And why the /
between passwd and [ ?
I would prefer (as was suggested earlier in the thread) that the syntax
for the entry for joe in the passwd file should be

/etc/passwd/joe

and the if you want to select joe's full name, then it should be

/etc/passwd/joe/fullname

and it would result in e.g. "Joe Smith" and

/etc/passwd/joe/shell

whould be the shell joe uses.

Of course something would have to tell the system that the passwd file
has one line for each user, and that fields within a line are separated
by ":"s and what the names of the fields are (e.g. the first field is
called "user"). And when you select inside the /etc/passwd file (or this
type of file) then the default interpretation of joe is that "user"
should be used to select the line.

So by default, /etc/passwd/joe should be equivalent to /etc/passwd[user
= "joe"]

But you should be able to select based on fullname too:

/etc/passwd[fullname = "Joe Smith"]

and

/etc/passwd[shell = "/bin/bash"]/user

should give you the user names of all users whose shell is /bin/bash,
right?

> But what to do with directories?
> Would 'cat /etc/[. = "passwd"]' output the contents of the passwd file
> or does it mean to output the file '[. = "passwd"]'?

I don't really see the point of this . = "passwd" syntax.

> If the first is the case then you have to prohibit filenames looking 
> like '[foo bar]'.

I think so.

> If the shells wouldn't like * for themself, I'd suggest something like
> cat /etc/*[. = "passwd"]
> This means: list all contents and show the ones where filename = "passwd".

but isn't that just /etc/passwd ? why complicate it?

> For the contents of /etc/passwd the following could become possible:
> 'cat /etc/passwd/*[. = "joe"]
> 'cat /etc/passwd/*[@shell = "/bin/tcsh"]

no, I think it should be 

cat /etc/passwd[shell = "bin/tcsh"]

why the *? and why the @? an attribute? why not simply a part of the
line with / ?

> To change all tcsh entries to bash:
> echo -n "/bin/bash" > /etc/passwd/*[@shell = "/bin/tcsh"]/@shell

I would say

echo -n "/bin/bash" > /etc/passwd[shell = "/bin/tcsh"]/shell


> What about mapping the contents of files into "pure" posix namespace?

Yes, that is exactly what I am suggesting, except that I would like to
extend the POSIX syntax by stealing some useful syntactic bits from
XPath.

> XML is basically a tree, too.
> Notes: 
> 1) "...." below is the entry to reiser4 namespace.
> 2) # denotes a shell command
> For example:
> 
> # cd /etc/passwd/
> # ls -a *
> . .. .... joe root
> # cd joe
> # ls
> gid home passwd shell uid

yes, but where is the username? that would be the first one listed here,
right?

> # cat shell
> /bin/tcsh
> # cd ../....
> # ls 
> plugins 
> 
> I guess an implementation in reiser4 would require some
> mime-type/file extension dispatcher plus a special
> directory plugin for each mime-type.


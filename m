Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUK0NOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUK0NOK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 08:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUK0NOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 08:14:10 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:16183 "EHLO
	mailrelay01.tugraz.at") by vger.kernel.org with ESMTP
	id S261207AbUK0NNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 08:13:12 -0500
From: Christian Mayrhuber <christian.mayrhuber@gmx.net>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
Subject: Re: file as a directory
Date: Sat, 27 Nov 2004 14:14:18 +0100
User-Agent: KMail/1.7.1
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <2c59f00304112205546349e88e@mail.gmail.com> <200411262213.58242.christian.mayrhuber@gmx.net> <1101553779.3680.28.camel@grape.st-and.ac.uk>
In-Reply-To: <1101553779.3680.28.camel@grape.st-and.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411271414.18801.christian.mayrhuber@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 November 2004 12:09, Peter Foldiak wrote:
> On Fri, 2004-11-26 at 21:13, Christian Mayrhuber wrote:
> > Regarding namespace unification + XPath:
> > For files: cat /etc/passwd/[. = "joe"] should work like in XPath.
> 
> I don't understand this. Why would you need the "."? And why the /
> between passwd and [ ?
Yes, I was confused by /etc/passwd/[username] in an earlier email.
I think we both mean basically the same.

> /etc/passwd/joe/shell
> 
> whould be the shell joe uses.
Yes.

> So by default, /etc/passwd/joe should be equivalent to /etc/passwd[user
> = "joe"]
Yes.
/etc/passwd/joe/shell would be equivalent to
/etc/passwd[shell = "/bin/bash"]/joe/shell if joe has bash as shell, right?

> 
> But you should be able to select based on fullname too:
> 
> /etc/passwd[fullname = "Joe Smith"]
Ok.
This means that any XPath like expression will need to return a directory 
entry representing a restricted view on the /etc/passwd contents.
The result of 'ls /etc/passwd[fullname = "Joe Smith"]' would be alike
'drwxr-xr-x  2 root root 48 2004-11-27 13:48 joe', right?

> 
> and
> 
> /etc/passwd[shell = "/bin/bash"]/user
> 
> should give you the user names of all users whose shell is /bin/bash,
> right?
I'm confused again.
I expected 'ls /etc/passwd[shell = "/bin/bash"]/user' to give you the
passwd entries of "user" and 'ls /etc/passwd[shell = "/bin/bash"]/' to
give the users that have a bash shell.


> > # cd /etc/passwd/
> > # ls -a *
> > . .. .... joe root
> > # cd joe
> > # ls
> > gid home passwd shell uid
> 
> yes, but where is the username? that would be the first one listed here,
> right?
joe is the username and a directory. There is no username entry in the
joe directory, because the username is already in the directory.
You can rename a user by renaming joe. 'mv joe newname'.

-- 
lg, Chris

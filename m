Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbUKXJTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUKXJTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUKXJTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:19:13 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:4303 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S262561AbUKXJRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:17:55 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Tomas Carnecky <tom@dbservice.com>, Helge Hafting <helge.hafting@hist.no>,
       Amit Gud <amitgud1@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <41A23496.505@namesys.com>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
	 <41A23496.505@namesys.com>
Content-Type: text/plain
Message-Id: <1101287762.1267.41.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Nov 2004 09:16:03 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 18:48, Hans Reiser wrote:
> Tomas Carnecky wrote:
> > Helge Hafting wrote:
> >> I recommend looking at archived threads about file as directory,
> >> you'll find many more arguments.  Currently there is one kind
> >> of support for archive files - loop mounts over files containing
> >> filesystem images.  These are not compressed though.
> >
> > Isn't reiserfs trying to implement such things? I've read that in some 
> > next version of reiserfs one will be able to open 
> > /etc/passwd/[username]  and get the informations about [username], 
> > like UID, GID, home directory etc.
> > Still true? And when can we except such a version of reiserfs?
> > tom
> >
> It was more that we said we would like to implement the functionality 
> necessary for doing that (e.g. inheritance), not that we would 
> specifically do /etc/passwd.  And that functionality will trickle in 
> over time.
> 
> Hans


I think something like

/etc/passwd/[username]

would be a really nice extension. The idea is more general, it would
unify the namespace for file selection and part-of-file selection.

So if you have a file named "/home/peter/book", you should be able to
look at its Introduction as "/home/peter/book/Introduction" or chapter
3, paragraph 2 as
/home/peter/book/chapter[3]/paragraph[2]

(this may not be the ideal syntax, but something like this should be
good.)

In this case you could use 
/home/peter/book/chapter[3]/paragraph[2]
as a "real" file, read it, even edit it in a text editor. When you later
look at the whole book as /home/peter/book , you should see your
changes.

The idea is related to the W3C "XPath"
http://www.w3.org/TR/xpath
http://www.w3schools.com/xpath/
XPath only applies within XML files, but it is mostly a superset of
current Unix file naming, so it would be natural to unify the two
namespaces. The idea is that you would use the same syntax for selecting
file and part-of-file in a way that the user doesn't even need to know
at which level they "cross over" to selecting within the file.
In the above example, it may be that each chapter is stored in a
separate "real" file. We don't even need to know. In a sense, the whole
concept of a "file" becomes a bit blurred. (What we need to think about
is which fragments to store metadata for, and which fragments should
simply inherit their metadata from the parent.)
Hans' tree-based file system is really ideal for this kind of thing.
I am not sure how closely we would want to follow the XPath syntax (it
has some nice ideas), but it should then be easy to write an plugin
doing XPath really efficiently on top of this.(And it could be made to
work for non-XML files as well.)

I would really like to implement this for the next version of Hans' file
system.
 Peter


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTJ3Uby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJ3Uby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:31:54 -0500
Received: from thunk.org ([140.239.227.29]:42129 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262794AbTJ3Ubw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:31:52 -0500
Date: Thu, 30 Oct 2003 15:31:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030203146.GA10653@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>,
	Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <20031030174809.GA10209@thunk.org> <3FA16545.6070704@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA16545.6070704@namesys.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 10:23:49PM +0300, Hans Reiser wrote:
> >Your assumption here is that the only thing that people search and
> >index on is semi-structed data.
> >
> No, my assumption is that structured data is a special case of 
> semi-structured data, and should be modeled that way.

There are much more powerful ways of handling structured data (as
opposed to generalized text searches).  What WinFS is specifically
addressing is searching and selected based on structured data.  

> >In addition, even for text-based files, in the future, files will very
> >likely not be straight ASCII, but some kind of rich text based format
> >with formatting, unicode, etc.
> >
> Formatting does not make text table structured.

No, but it means that doing searches on formatted text is very
difficult, and should be done in userspace, not kernel space.

> You are missing my argument.  I am saying that the indexes and name 
> space belong in the kernel, not that the auto-indexer belongs in the kernel.

Searching and name spaces are different things.  Fundamentally I
disagree with your belief that they are the same thing (and yes I've
read your whitepaper on the namesys web page).  You can do much, much
more powerful select statements than makes sense to do via the
directory abstraction.  (Think about arbitrary select statements,
possibly with subselect statements.  That's what Microsoft is
promising in WinFS.  Do you really want to support an opendir system
call where its argument is an arbitrary SQL select statement?  I
didn't think so.)

There is a very, very big difference between a pathname, which is
guaranteed to be refer to a single unique file, such as might be used
in a Makefile.  This is what most people consider a real namespace.
When addressing people, a passport number, or a driver's license
number, or a social security number, are all examples of a namespace.
Each one of these is guaranteed to return either no result, or a
single specific person.  

In contrast, consider searching for someone who is male, between 30
and 40, is named Tom, and lived in Libertyville, Illinois sometime
between 1960 and 1970, and is married to someone named Mary who was
born in California.  This might return several people, and most people
would **NOT** consider the space of all queries about people to be a
"name space".  Searches are not names.  They do not uniquely identify
people or objects, which is a fundamental requirement of a name.

We can create a filesystem with a directory indexed by social security
number, and another directory with hard links that indexes people's
records by driver's ID.  That makes sense.  But putting in sufficient
indexes so that the above query of looking for somone named Tom who is
married to someone named Mary (and this is an example where an query
optimizer would be needed) is simple, pure insanity.

> uh, all the time, if there is a namespace that lets him.  How often do 
> you use google?  How often do you memorize the primary key of an object 
> in a relational database, and use only that versus how often do you do a 
> richer query?

I use google dozens of times a day.  I type commands to bash hundreds
of times a day.  Does that mean that bash command line parsing should
be in the kernel?  Of course not!

The bottom line is that for something that happens dozens or even
hundreds of times a day, that's an argument that it *shouldn't* be
done in the kernel.  Compare and contrast that with handling incoming
network packets, which can happen millions of times per hour.

						- Ted

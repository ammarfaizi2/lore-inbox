Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTJaNxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTJaNxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:53:33 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:53493 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263304AbTJaNxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:53:31 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Kenneth Johansson <ken@kenjo.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Things that Longhorn seems to be doing right
Date: Fri, 31 Oct 2003 07:52:49 -0600
X-Mailer: KMail [version 1.2]
Cc: Hans Reiser <reiser@namesys.com>, Erik Andersen <andersen@codepoet.org>,
       linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031030174809.GA10209@thunk.org> <1067598091.4434.19.camel@tiger>
In-Reply-To: <1067598091.4434.19.camel@tiger>
MIME-Version: 1.0
Message-Id: <03103107524900.25554@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 05:01, Kenneth Johansson wrote:
> On Thu, 2003-10-30 at 18:48, Theodore Ts'o wrote:
> > The bottom line is that if a case can be made that some portion of the
> > functionality required by WinFS needs to be in the kernel, and in the
> > filesystem layer specifically, I'm all in favor of it.  But it has to
>
> What about some way to quickly detect changes to the filesystem. That
> would really help any type of indexing function to avoid scanning the
> entire disk.
>
> It would help things like backup and even the locate database.
>
> It could be something simple as a modification number that increased
> with every change combined with a size limited list of what every change
> was. Then every indexing task could just store what the modification
> number was last time it did it's work compare that number to the current
> number and read all the changes from the change log. If the stored
> modification number had fallen out of the log it has to go over the
> entire filesystem but that would not have to happen that often with a
> big enough log.
>
> Probably some optimisation have to be done to keep the log small you do
> not want to store every putc as a separate event.

Putc isn't the problem - that caches up full blocks of data before giving
them to the kernel.

The problem would be something like syslog, which you really might like to
search/index frequently (real time analysis).

No log would be able to handle all cases, and you will have to figure out
what to do for the exceptions, and recovery procedures when that fails.

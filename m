Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUBTPBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBTPBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:01:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62917 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261244AbUBTPBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:01:10 -0500
Subject: Re: JFS default behavior / UTF-8 filenames
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: kernel@mikebell.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040219234746.GG432@tinyvaio.nome.ca>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
	 <20040219105913.GE432@tinyvaio.nome.ca>
	 <1077199506.2275.12.camel@shaggy.austin.ibm.com>
	 <20040219234746.GG432@tinyvaio.nome.ca>
Content-Type: text/plain
Message-Id: <1077289257.2533.23.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 09:00:58 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-19 at 17:47, kernel@mikebell.org wrote:
> While I don't really care one way or the other about the whole
> "rejecting non-UTF8 filenames" thing, trying to store 8bit strings in
> UTF2 (no such thing, is there? Is JFS UCS-2 or UTF-16?)

UCS-2 - I can't keep this stuff straight.

>  seems really
> ugly. In general at least, maybe it's not so bad in JFS's case
> specifically because of there not being much sharing of JFS filesystems
> between linux and non-linux systems.
> 
> But if JFS uses that "make the high byte zero and return the low byte
> only" scheme, what does it do when it encounters a UCS-2 filename that
> has a non-NUL high byte on an existing filesystem? I can't see any ways
> of dealing with this that aren't much more horribly broken than merely
> refusing to create filenames that aren't valid in the current encoding.
> If it throws the high byte away then you've made it impossible to open
> said files, and up to 256 files per character of the filename can now
> appear to have the same filename.
> 
> So what does JFS do in its "throw away the high byte and store binary
> character strings in the low byte" mode? How does it deal with an
> existing filesystem that has filenames that don't conform to said rule?

With no iocharset specified, a filename with such a character will be
inaccessible.  Probably the best thing for readdir to do is to
substitute a '?' and print a message to the syslog to mount the volume
with iocharset=utf8 to be able to access the file.  Of course I would
limit the number of printk's to something small.  I'll submit a patch to
do this.
-- 
David Kleikamp
IBM Linux Technology Center


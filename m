Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUBSXrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUBSXrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:47:21 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:26760 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S267585AbUBSXrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:47:18 -0500
Date: Thu, 19 Feb 2004 15:47:47 -0800
From: kernel@mikebell.org
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior / UTF-8 filenames
Message-ID: <20040219234746.GG432@tinyvaio.nome.ca>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040219105913.GE432@tinyvaio.nome.ca> <1077199506.2275.12.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077199506.2275.12.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:05:06AM -0600, Dave Kleikamp wrote:
> The arbitrary string of bytes is treated as the latin1 charset in that
> it is stored as 0x00nn (in UTF2), but JFS really doesn't care what the
> character set is.

While I don't really care one way or the other about the whole
"rejecting non-UTF8 filenames" thing, trying to store 8bit strings in
UTF2 (no such thing, is there? Is JFS UCS-2 or UTF-16?) seems really
ugly. In general at least, maybe it's not so bad in JFS's case
specifically because of there not being much sharing of JFS filesystems
between linux and non-linux systems.

But if JFS uses that "make the high byte zero and return the low byte
only" scheme, what does it do when it encounters a UCS-2 filename that
has a non-NUL high byte on an existing filesystem? I can't see any ways
of dealing with this that aren't much more horribly broken than merely
refusing to create filenames that aren't valid in the current encoding.
If it throws the high byte away then you've made it impossible to open
said files, and up to 256 files per character of the filename can now
appear to have the same filename.

So what does JFS do in its "throw away the high byte and store binary
character strings in the low byte" mode? How does it deal with an
existing filesystem that has filenames that don't conform to said rule?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUBLDym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 22:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUBLDyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 22:54:41 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:49425 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S266170AbUBLDyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 22:54:39 -0500
Date: Wed, 11 Feb 2004 19:54:35 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040212035435.GB19507@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20040209115852.GB877@schottelius.org> <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au> <1076517309.21961.169.camel@shaggy.austin.ibm.com> <20040212004532.GB29952@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212004532.GB29952@hexapodia.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause sleeplessness, irritability, loss of appetite, anxiety, depression, or other psychological disorders.  Consult your doctor if these symptoms persist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 06:45:32PM -0600, Andy Isaacson wrote:
> On Wed, Feb 11, 2004 at 10:35:10AM -0600, Dave Kleikamp wrote:
> > Yeah, JFS has poor default behavior based on CONFIG_NLS_DEFAULT.  I
> > attempted to explain why it works that way in the first bug listed above
> > if anyone is curious.
> 
> I think your suggested fix is good, but it begs the question:
> 
> Why on earth is JFS worried about the filename, anyways?  Why has it
> *ever* had *any* behavior other than "string of bytes, delimited with /,
> terminated with \0" ?
> 
> I read your response about OS/2, and maybe I'm just slow, but I don't
> see what that has to do with anything.
> 
> Does JFS on AIX have the same buggy behavior?
> 
> What behavior was the code originally designed to implement, on OS/2?
> Why was that behavior chosen rather than "filenames are a string of
> bytes"?
> 
> Feel free to point to a "Design of the OS/2 JFS interface" document if
> such exists and answers my question. :)

His first link almost explains it.

| In OS/2, the kernel had access to each process's locale
| information, and converting the pathnames from the user's
| charset to unicode made access to the filesystem very
| transparent, even when users used different character sets
| on the same computer. 
| 
| Unfortunately, in Linux the kernel has no per-process
| information to go on, so it uses the charset specified by
| CONFIG_NLS_DEFAULT when the kernel is built. Obviously,
| this is neither intuitive or generally useful. 
| 
| I am considering changing the default behavior to
| trivially convert the user-supplied pathnames to utf-16
| when stored in on-disk. This default behavior could be
| overridden by specifying the iocharset= mount flag.

Apparently in OS2 they implemented a policy of utf-16 into
the kernel so that applications would not have to be as
locale aware.  This could be called kernel pollution.

For Linux there is no policy except perhaps in userspace.
It is up to userspace to determine what the policy will be
regarding charset for filename storage.  Common practice
seems to be utf-8.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

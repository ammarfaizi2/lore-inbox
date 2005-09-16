Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbVIPINO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbVIPINO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbVIPINO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:13:14 -0400
Received: from ns.firmix.at ([62.141.48.66]:37762 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1161127AbVIPINM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:13:12 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: "\"Martin v." =?ISO-8859-1?Q?L=F6wis=22?= <martin@v.loewis.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4329BFDC.70600@v.loewis.de>
References: <4B2ZV-2dl-7@gated-at.bofh.it> <4HKbZ-Cx-37@gated-at.bofh.it>
	 <4329BC43.7030406@v.loewis.de> <4329BCAB.1090106@zytor.com>
	 <4329BFDC.70600@v.loewis.de>
Content-Type: text/plain; charset=UTF-8
Organization: Firmix Software GmbH
Date: Fri, 16 Sep 2005 10:13:01 +0200
Message-Id: <1126858381.30155.12.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 20:39 +0200, "Martin v. Löwis" wrote:
> H. Peter Anvin wrote:
> 
> > In Unix, it's a hideously bad idea.  The reason is that Unix inherently
> > assumes that text streams can be merged, split, and modified.  In other
> > words, unless you can guarantee that EVERY program can handle BOM
> > EVERYWHERE, it's broken.
> 
> This argument is bogus. We are talking about scripts here, which cannot
> be merged, split, and modified. You don't cat(1) or sort(1) them - it's

Sure they can since they are plain text files.
How do you think one merges scripts?
Just `cat`ing them all into one new file and edit that new file is much
faster and simpler than to open an empty new file with your editor, then
you open all the other scripts in your editor and copy them by hand.
And you (or at least I) do `grep`/`egrep`/`fgrep`, `wc` them. And
probably with several other tools too - think of `find <dir> -type f
-print0 | xargs -0r <cmd>`.

> just pointless to do that. You create them with text editors, and those
> *can* handle the UTF-8 signature.

It is not uncommon to create scripts and the like with other programs,
other scripts, what-else.
Apart from the fact the a "script" is merely a plain text file with the
eXecutable bit set. And *that* is the only difference, so you have to at
least (all instances of) `chmod` to insert and remove the BOM.
This gets funny if you think of file systems without a concept of
"executable bit" and copying files around. Another standard tool to
patch.
And how do you solve `cat`ing a script (with set X bit) like:
`cat <script >other-file` where other-file will not have the X bit set. 
The `cat` program doesn't even know (or care about) the names of the two
files.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


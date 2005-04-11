Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVDKHUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDKHUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDKHUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:20:12 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:56800 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261714AbVDKHUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:20:04 -0400
To: bert hubert <ahu@ds9a.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Christopher Li <lkml@chrisli.org>,
       Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
	<20050410115055.2a6c26e8.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
	<20050410190331.GG13853@64m.dyndns.org>
	<Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
	<20050411065745.GA29688@outpost.ds9a.nl>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 11 Apr 2005 09:20:01 +0200
In-Reply-To: <20050411065745.GA29688@outpost.ds9a.nl>
Message-ID: <m3fyxxhja6.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> writes:

> On Sun, Apr 10, 2005 at 03:38:39PM -0700, Linus Torvalds wrote:
> 
> > compressed with zlib, they are all named by the sha1 file, and they all 
> 
> Now I know this is a concious decision, but recent zlib allows you to write
> out gzip content, at a cost of 14 bytes I think per file, by adding 32 to
> the window size. This in turn would allow users to zcat your objects at
> ease.
> 
> You get confirmation of completeness of the file for free, as gzip encodes
> the length of the file at the end.

I would very much like it if git used normal gzip files with a .gz
extension.  Doing it this way means that the compression methods can
be extended in the future.  I.e:

    ab/1234567890.gz	gzip compressed
    ab/1234567890.xd	xdelta compressed

I find the xdelta encoding very attractive since it can probably
reduce the size of the repository drastically.  A compression script
could for run nightly and xdelta compress everything that's older than
a few months (to figure out what files to create the delta from, just
look at the commit files and compare the parent tree to the current
tree).

Of course, this means that a dumb wget won't work all that well to
synchronize two trees, but it might be worthwile anyways.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se

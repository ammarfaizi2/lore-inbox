Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWDEUIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWDEUIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWDEUIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:08:11 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:15521
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751160AbWDEUIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:08:10 -0400
Date: Wed, 5 Apr 2006 13:07:20 -0700
From: Greg KH <gregkh@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Al Viro <viro@ftp.linux.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060405200720.GA3820@suse.de>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <20060405152123.GH27946@ftp.linux.org.uk> <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com> <20060405153957.GI27946@ftp.linux.org.uk> <200604051958.k35JwF0M019652@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604051958.k35JwF0M019652@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 03:58:15PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 05 Apr 2006 16:39:57 BST, Al Viro said:
> 
> > How about _NOT_ using sysfs and just having ->read()/->write() on a file in fs
> > of your own?  ~20 lines for all of it, not counting #include...
> 
> Great.  Instead of everybody using the same piece-of-manure sysfs interface,
> each driver carries around its 20 lines to implement read() and write() in
> subtly buggy and incompatible ways.
> 
> % grep nodev /proc/filesystems | wc -l
> 19
> 
> That's fsck'ing insane already.

What is insane is using sysfs in ways it was not designed to do so.  The
color map is clearly not a "single, small value".  I have recommended
that the binary file in sysfs be used instead, as that is a designed
solution, but the authors do not want to do so for some odd reason.

So, we have a number of proposed solutions:
	- custom fs
	- binary sysfs file
	- configfs
and yet, people still complain...

bleah.

greg k-h

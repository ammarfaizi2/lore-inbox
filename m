Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTKOUgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKOUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:36:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50916 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262038AbTKOUgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:36:08 -0500
Date: Sat, 15 Nov 2003 20:36:07 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Harald Welte <laforge@netfilter.org>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115203607.GP24159@parcelfarce.linux.theplanet.co.uk>
References: <20031115093833.GB656@obroa-skai.de.gnumonks.org> <20031115171843.GN24159@parcelfarce.linux.theplanet.co.uk> <20031115173310.GA4786@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115173310.GA4786@obroa-skai.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 06:33:10PM +0100, Harald Welte wrote:
> On Sat, Nov 15, 2003 at 05:18:44PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Sat, Nov 15, 2003 at 10:38:33AM +0100, Harald Welte wrote:
> > > that doesn't help.  As I am aware, the seq_file structure is only
> > > allocated in the seq_open() call.  How does seq_open() know which
> > > private data (i.e. hash table) to associate with struct file?
> > 
> > Why should seq_open() know that?  Its caller does and it can set the damn
> > thing to whatever it wants.
> 
> So who is the caller? it's the ->open() member of struct
> file_operations.  and struct file_operations doesn't have some private
> member where I could hide my pointer before saving it to
> seq_file.private in seq_open().

If arguments of ->open() were not enough to find your data, how the hell would
current code manage to find it?

You've got inode; you've got (if that's on procfs) proc_dir_entry - from
inode; you've got dentry (from struct file *).  If that's not enough to
find your data, what is?

Which files do you have in mind?

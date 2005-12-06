Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVLFR3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVLFR3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVLFR3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:29:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6532 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932440AbVLFR3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:29:21 -0500
Date: Tue, 6 Dec 2005 17:29:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 2/12] relayfs: export relayfs_create_file() with fileops param
Message-ID: <20051206172910.GA24362@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, karim@opersys.com
References: <17268.51814.215178.281986@tut.ibm.com> <17268.51975.485344.880078@tut.ibm.com> <20051111193749.GA17018@infradead.org> <17268.62897.434122.165183@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17268.62897.434122.165183@tut.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 01:49:05PM -0600, Tom Zanussi wrote:
> Christoph Hellwig writes:
>  > On Fri, Nov 11, 2005 at 10:47:03AM -0600, Tom Zanussi wrote:
>  > > This patch adds a mandatory fileops param to relayfs_create_file() and
>  > > exports that function so that clients can use it to create files
>  > > defined by their own set of file operations, in relayfs.  The purpose
>  > > is to allow relayfs applications to create their own set of 'control'
>  > > files alongside their relay files in relayfs rather than having to
>  > > create them in /proc or debugfs for instance.  relayfs_create_file()
>  > > is also used by relay_open_buf() to create the relay files for a
>  > > channel.  In this case, a pointer to relayfs_file_operations is passed
>  > > in, along with a pointer to the buffer associated with the file.
>  > 
>  > Again, NACK,  control files don't belong into relayfs.
>  > 
> 
> Sure, applications could just as easily create these same files in
> /proc, /sys, or /debug, but since relayfs is a filesystem, too, it
> seems to me to make sense to take advantage of that and allow them to
> be created alongside the relay files they're associated with, in
> relayfs.

Didn't we have that discussion before?  If we want a mix-and-match fs
just redo relayfs into a library of file operations for debugfs
(or anything else that can use file_operations for that matter)


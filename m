Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVKDPQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVKDPQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVKDPQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:16:56 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:25057 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964848AbVKDPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:16:55 -0500
Date: Fri, 4 Nov 2005 16:16:46 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: jblunck@suse.de
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104151646.GB31827@wohnheim.fh-wedel.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051104151104.GA22322@hasse.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 November 2005 16:11:04 +0100, jblunck@suse.de wrote:
> 
> True. Seeking to that offset should at least fail and shouldn't stop at the
> new entry. But SuSV3 says that the offset given by telldir() is valid until
> the next rewinddir().  This is no problem for directories that can only grow.
> I tried to implement some kind of deferred dput'ing of the d_child's but that
> was too hackish and was wasting memory. So the best thing I can do now is fail
> if someone wants to seek to an offset of an already unlinked file.

Does that mean that, to satisfy the standard, you'd have to allow the
seek, but return 0 bytes on further reads, as you're already at (or
beyond, whatever) EOF?

Sounds quite ugly and it would be nice if this wasn't necessary.

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein

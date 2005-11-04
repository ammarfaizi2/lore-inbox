Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbVKDLvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVKDLvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 06:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVKDLvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 06:51:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:4777 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932727AbVKDLvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 06:51:02 -0500
Date: Fri, 4 Nov 2005 11:51:01 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: jblunck@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104115101.GH7992@ftp.linux.org.uk>
References: <20051104113851.GA4770@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104113851.GA4770@hasse.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 12:38:51PM +0100, jblunck@suse.de wrote:
> This patch effects all users of libfs' dcache directory implementation.
> 
> Old glibc implementations (e.g. glibc-2.2.5) are lseeking after every call to
> getdents(), subsequent calls to getdents() are starting to read from a wrong
> f_pos, when the directory is modified in between. Therefore not all directory
> entries are returned. IMHO this is a bug and it breaks applications, e.g. "rm
> -fr" on tmpfs.
> 
> SuSV3 only says:
> "If a file is removed from or added to the directory after the most recent
> call to opendir() or rewinddir(), whether a subsequent call to readdir_r()
> returns an entry for that file is unspecified."
 
IOW, the applications in question are broken since they rely on unspecified
behaviour, not provided by old libc versions.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVKDNSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVKDNSa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbVKDNSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:18:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751420AbVKDNS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:18:29 -0500
Date: Fri, 4 Nov 2005 14:18:58 +0100
From: jblunck@suse.de
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jblunck@suse.de, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104131858.GA16622@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Miklos Szeredi wrote:

> > > > 
> > > > SuSV3 only says: "If a file is removed from or added to the
> > > > directory after the most recent call to opendir() or
> > > > rewinddir(), whether a subsequent call to readdir_r() returns an
> > > > entry for that file is unspecified."
> > >  
> > > IOW, the applications in question are broken since they rely on
> > > unspecified behaviour, not provided by old libc versions.
> > 
> > No. SuSV3 only says that the behavior of readdir() is unspecified
> > w.r.t. an entry for the removed/added file. I think readdir() should
> > still return the entries which are not removed/added. What do you
> > think?
> 
> What 'rm' is this?  Mine (coreutils 5.2.1) doesn't do any seeking and
> I don't think that glibc does either.
> 

As I said:
"Old glibc implementations (e.g. glibc-2.2.5) are lseeking after every call to
getdents() ..."

Precisely this is a SLES8 on s390-64bit.
s390vm02:/# rpm -qf /bin/rm
fileutils-4.1.11-144
s390vm02:/# rpm -q glibc
glibc-2.2.5-234

But you can also try my testcase.

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVKDPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVKDPpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVKDPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:45:52 -0500
Received: from ns1.suse.de ([195.135.220.2]:56285 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964968AbVKDPpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:45:51 -0500
Date: Fri, 4 Nov 2005 16:46:10 +0100
From: jblunck@suse.de
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jblunck@suse.de, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104154610.GB23962@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, Miklos Szeredi wrote:

> > 
> > Well, glibc is that stupid and triggers the bug.
> 
> Seems to me, the simple solution is to upgrade your glibc.
> 

This is SLES8. You don't want to update the glibc.

> > 
> > True. Seeking to that offset should at least fail and shouldn't stop at the
> > new entry.
> 
> No it should _not_ fail, it should continue from the next _existing_
> entry.
> 

And how do we achieve this for all the libfs users like tmpfs etc.? At least
with my patch you can seek to the offsets of existing entries. Even that isn't
possible at the moment if you remove directory entries. But I don't know how to
implement that for the offsets of unlinked entries.

> 
> No good.  Same problem if you move out then move back the entry.
> 

Yeah, I know.

Regards,
	Jan Blunck

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de

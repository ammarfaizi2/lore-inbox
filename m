Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289357AbSBEJUA>; Tue, 5 Feb 2002 04:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289363AbSBEJTu>; Tue, 5 Feb 2002 04:19:50 -0500
Received: from ns.muni.cz ([147.251.4.33]:233 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S289357AbSBEJTh>;
	Tue, 5 Feb 2002 04:19:37 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <3C5FA3A7.BA524F5F@i.am>
Date: Tue, 5 Feb 2002 09:19:35 GMT
To: Jeff Garzik <garzik@havoc.gtf.org>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020201132953.A27508@havoc.gtf.org>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre6 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> On Fri, Feb 01, 2002 at 09:06:37AM -0800, Linus Torvalds wrote:
> > Even databases often use multiple files, and quite frankly, a database
> > that doesn't use mmap and doesn't try very hard to not cause extra system
> > calls is going to be bad performance-wise _regardless_ of any page cache
> > locking.
> 
> I've always thought that read(2) and write(2) would in the end wind up
> faster than mmap(2)...  Tests in my rewritten cp/rm/mv type utilities
> seem to bear this out.
> 
> Is mmap(2) only preferred for large files/databases?
 
I've tried to make faster md5summing program and programmed several
ways of accessing file - for the very large files the fastest
way seemed to be  O_DIRECT with threaded precaching.

For fast mmap access I'd to implement two parallel mmpad areas with
madvise MADV_WILLNEED  - then it was almost as fast as read


-- 
  .''`.  Which fundamental human right do you want to give up today?
 : :' :      Debian GNU/Linux maintainer - www.debian.{org,cz}
 `. `'  Zdenek Kabelac  kabi@{debian.org, users.sf.net, fi.muni.cz}
   `-              When in doubt, just blame the Euro. :)


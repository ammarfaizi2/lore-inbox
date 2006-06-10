Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWFJRMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWFJRMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWFJRMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:12:43 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:58440 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751660AbWFJRMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:12:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZm0NH0nQu7ge3b8kC4UJgWC+GWMoYSKTAYSj/6jqIBmnCW5apnZOfauS0AnWlPO4038Bw6IwWgQU9MmTjTeWFqOkfvAE03KfkKvkW220jHWN5vdOqDyJAHBLkx1gA+suXxATh+TkxUpN7H5tpmTaIXGLLskARKDchHlxrTqjmY=
Message-ID: <4ae3c140606101012y6668fd5co7b7d2d453bb02397@mail.gmail.com>
Date: Sat, 10 Jun 2006 13:12:39 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: How long can an inode structure reside in the inode_cache?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060610121318.GQ1651@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
	 <20060610121318.GQ1651@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No. I guess I didn't make my question clear.

My question is: Will an inode be released after the last file refers
to this is closed? If so, this could bring a performance issue.
Consider this case: a process open a file, read it, close it, then
reopen this file, read it, close it. For every open,  the inode has to
be read from disk again, which make hurt performance.

So I think inode should stay in inode_cache for a while, not released
right after the last file stops referring it. I just want to know
whether my guess is right. If it is, when will kernel release the
inode, since an inode cannot stay in memory forever.

xin

On 6/10/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Fri, Jun 09, 2006 at 08:10:10PM -0400, Xin Zhao wrote:
> > I was wondering how Linux decide to free an inode from the
> > inode_cache? If a file is open, an inode structure will be created and
> > put into the inode_cache, but when will this inode be free and removed
> > from the inode_cache? after this file is closed? If so, this seems to
> > be inefficient.
>
> how can you possibly release an inode while the file's still open?
> look at all the information stored in the inode, like the length of the
> file, last accessed time, not to mention which filesystem the inode
> belongs to.
>

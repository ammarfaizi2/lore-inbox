Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWHQKFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWHQKFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 06:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWHQKFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 06:05:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:32644 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932467AbWHQKFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 06:05:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pzrxnagRienZPVucfaCIsONx6XGUKCcrcPGvrHLcsaNDJmwmQiqYkiB2zmwn3H95XM0oPLO/Kr9pwOXILq62Tjf9Dn/Tyb21Xg25yGa8g9orlnxxieuD2XSJFOH+B08PzYKuhhr3k9myhhAx316P573JGryYqA9Wyg+zc7JII0Q=
Message-ID: <9a8748490608170305v53a2fd20q29d12e2a7b7229d4@mail.gmail.com>
Date: Thu, 17 Aug 2006 12:05:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] NFS: possible NULL pointer deref in nfs_sillyrename()
Cc: linux-kernel@vger.kernel.org, "Rick Sladkey" <jrs@world.std.com>,
       "Neil Brown" <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net
In-Reply-To: <1155773801.6739.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608170022.29168.jesper.juhl@gmail.com>
	 <1155773801.6739.5.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Thu, 2006-08-17 at 00:22 +0200, Jesper Juhl wrote:
> > The coverity checker spotted this as bug #1013.
> >
> > If we get a NULL dentry->d_inode, then regardless of
> > NFS_PARANOIA or no NFS_PARANOIA, then if
> >    if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
> > turns out to be false we'll end up dereferencing
> > that NULL d_inode in two places below.
> >
> > And since the check for "(!dentry->d_inode)" even exists
> > (although inside #ifdef NFS_PARANOIA) I take that to mean
> > that this is a possibility.
>
> Sorry, but it isn't possible. See the checks in may_delete() (which is
> called before ->unlink()) and nfs_rename().
>
Thanks, that was useful info.

> IOW: Feel free to kill the NFS_PARANOIA crap. It looks like legacy code
> from a debugging session about a decade or so ago.
>
Sure thing, I'll cook up a patch to do that.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWFMSIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWFMSIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWFMSIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:08:42 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:57101 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932153AbWFMSIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:08:41 -0400
Message-ID: <448EFF23.6070703@argo.co.il>
Date: Tue, 13 Jun 2006 21:08:35 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Nathan Scott <nathans@sgi.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
References: <20060613174407.GA6561@thunk.org>
In-Reply-To: <20060613174407.GA6561@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2006 18:08:40.0105 (UTC) FILETIME=[660F8990:01C68F14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
>
> On Tue, Jun 13, 2006 at 05:00:59PM +0300, Avi Kivity wrote:
> >
> > It can be made into an inode operation:
> >
> >    if (inode->i_ops->getblksize)
> >         return inode->i_ops->getblksize(inode);
> >    else
> >         return inode->i_sb->s_blksize;
> >
> > Trading some efficiency for space.
>
> Yep, that was what I was planning on doing....
>

Maybe

    if (inode->i_sb->s_blksize)
        return inode->i_sb->s_blksize;
    else
        ...

is a tiny little bit faster...

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


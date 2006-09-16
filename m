Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWIPPFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWIPPFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWIPPFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 11:05:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:46475 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751755AbWIPPFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 11:05:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XoJfY7rE06s5gmopSM140isaUWHGhF9OmfW/K20AoSCNaiesnI9LXA9eHBTaCytQcxdI/PZXeBmRS25RFe8gYzydVZ3DSR7UyK1VZR7VM/mlFbb/sOGn96STYI1MCZXBW1qFQkcWpEUKSAByjzTGYYAr4DVIS5IMbTxSvere0KA=
Message-ID: <401f4f10609160805n20e22c44h138af3c9160f747e@mail.gmail.com>
Date: Sat, 16 Sep 2006 18:05:07 +0300
From: "Pavel Mironchik" <tibor0@gmail.com>
To: "Jan Kara" <jack@suse.cz>
Subject: Re: Fwd: ext2/3 create large filesystem takes too much time; solutions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060915115655.GA21992@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <401f4f10609120407j6816372mfdfea392dcae9e00@mail.gmail.com>
	 <401f4f10609140052g48a92406i248f0f2c4175540d@mail.gmail.com>
	 <20060915115655.GA21992@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

Probably you are right, but there are lot of competitive filesystems
(reiser,xfs) that do not require such period on creation. I hope at
least Ext4 users will not suffer about that.

Pavel.

On 9/15/06, Jan Kara <jack@suse.cz> wrote:
>   Hello,
>
> > Ext2/3 does erase of inode tables, when do creation of new systems.
> > This is very very long operation when the target file system volume is more
> > than
> > 2Tb. Other filesystem are not affected by such huge delay on creation of
> > filesystem. My concern was to improve design of ext3 to decrease time
> > consuption of creation large ext3 volumes on storage servers.
> > In general to solve problem, we should defer job of cleaning nodes to
> > kernel. In e2fsprogs there is LAZY_BG options but it  just avoids doing
> > erase of inodes only.
> >
> > I see several solutions for that problem:
> > 1) Add special bitmaps into fs header (inode groups descriptors?).
> > By looking at those bitmaps kernel could determine if inode is not cleaned,
> > and
> > that inode will be propertly initialized.
> > 2) Add special identifiers into inodes. If super block id != inode id
> > -> inode is dirty
> > and should be cleaned in kernel, where super block id is generated on
> > creation stage.
>   Hmm, I don't know but how often do you need to create so big
> filesystems? My feeling is that one can usually afford to spend some
> time with a creation of a filesystem (and it is better to spend it
> during creation than to add complexity to the run-time code). Also
> having inodes zeroed out is more robust when filesystem is corrupted or
> some other nasty thing happens... Just my 2 cents :)
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
>

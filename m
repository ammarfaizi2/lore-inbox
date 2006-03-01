Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWCAPXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWCAPXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWCAPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:23:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:28045 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932226AbWCAPXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:23:42 -0500
From: Chris Mason <mason@suse.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: o_sync in vfat driver
Date: Wed, 1 Mar 2006 10:23:37 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
References: <op.s5lrw0hrj68xd1@mail.piments.com> <200602281347.46169.mason@suse.com> <87u0aiw6pi.fsf@duaron.myhome.or.jp>
In-Reply-To: <87u0aiw6pi.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011023.38229.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 10:00, OGAWA Hirofumi wrote:
> Chris Mason <mason@suse.com> writes:
> > @@ -329,6 +330,11 @@ static int msdos_create(struct inode *di
> >  	d_instantiate(dentry, inode);
> >  out:
> >  	unlock_kernel();
> > +	if (!err && MSDOS_SB(sb)->options.flush) {
> > +		writeback_inode(dir);
> > +		writeback_inode(inode);
> > +		writeback_bdev(sb);
> > +	}
> >  	return err;
> >  }
>
> If buffers is already queued for I/O, and if you don't wait anything,
> the buffers wouldn't be (re-)submited, then those buffers will be
> flushing by normal periodically wb_kupdate() after all.

Just to make sure we're using the same terms, do you mean the pages are marked 
dirty and on the SB's dirty list, or do you mean the page has been through 
writepage and is currently on its way to the disk?

>
> Do you have any plan to address it? Or I'm just missing something?

If you mean the page is just dirty, it will get written by the 
filemap_fdatawrite calls.  If you mean the page is PG_writeback, it is 
already on the way to the disk, so it passes the 'blinking light on the 
memory stick' rule.

-chris

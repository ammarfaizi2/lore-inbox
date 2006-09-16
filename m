Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWIPNkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWIPNkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 09:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWIPNkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 09:40:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23480 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751332AbWIPNkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 09:40:13 -0400
Date: Sat, 16 Sep 2006 14:39:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
Message-ID: <20060916133947.GA1498@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Steven Whitehouse <swhiteho@redhat.com>,
	linux-kernel@vger.kernel.org,
	Russell Cattelan <cattelan@redhat.com>,
	David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>
References: <1157031183.3384.793.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >+struct file gfs2_internal_file_sentinal = {
> >+	.f_flags = O_NOATIME|O_RDONLY,
> >+};

Statically allocation a struct file is not allowed.  Where do you use
gfs2_internal_read?  It really shouldn't be needed.

> >+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
> >+{
> >+	int error;
> >+
> >+	if (strcmp(current->comm, "nfsd") != 0)
> 
> Is not there a better way to do this? Note that there is also a "nfsd4" process

This is in fact not allowed at at all.  Please fix you readdir code not to
need special cases for nfsd.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbTD3PPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTD3PPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:15:23 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:14860 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262266AbTD3PPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:15:21 -0400
Date: Wed, 30 Apr 2003 16:27:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430162739.A9255@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030430160239.A8956@infradead.org> <200304301513.h3UFDNGi023355@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304301513.h3UFDNGi023355@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Wed, Apr 30, 2003 at 11:13:23AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:13:23AM -0400, chas williams wrote:
> at the time afs was written it wasnt a mistake.

Oh yes, it was.  The same mistake as the even earlier SysV IPC mess.

> syscall was the only
> (easy) way into the kernel from user space.  adding multiple syscalls
> would have just been completely painful.  as for examples, pioctl() --
> the user space of the afs syscall -- is a bit like syssgi() i am afraid:
> 
> venus/fs.c:     code = pioctl(0, VIOC_GETCELLSTATUS, &blob, 1);
> venus/fs.c:    code = pioctl(0, VIOC_SETRXKCRYPT, &blob, 1);
> vlserver/sascnvldb.c:   code = pioctl(ti->data, VIOCGETVOLSTAT, &blob, 1);
> auth/ktc_nt.c:  code = pioctl(0, VIOCNEWGETTOK, &iob, 0);
> auth/ktc_nt.c:  code = pioctl(0, VIOCDELTOK, &iob, 0);
> package/package.c:  code = pioctl(0, VIOC_AFS_SYSNAME, &data, 1);
> venus/up.c:          code = pioctl(file1, _VICEIOCTL(2), &blob, 1);
> 
> in reality, very few things other than afs are going to want to use
> the afs syscall (arla might be a possible user).

So fix the AFS code up to use a routine for each subcall that
can still map to pioctl for !linux.  After that we can continue the
discussion on how these calls are best implemented on linux.

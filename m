Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTD3PCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTD3PCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:02:22 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:55433 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262223AbTD3PCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:02:21 -0400
Message-Id: <200304301513.h3UFDNGi023355@locutus.cmf.nrl.navy.mil>
To: Christoph Hellwig <hch@infradead.org>
cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall 
In-reply-to: Your message of "Wed, 30 Apr 2003 16:02:39 BST."
             <20030430160239.A8956@infradead.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 30 Apr 2003 11:13:23 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030430160239.A8956@infradead.org>,Christoph Hellwig writes:
>We need to repeat a mistake others did has never been a valid
>argument in linux devlopment..  Anyway, it's really hard to judge about
>this before seeing the actual implementation instead of just saying
>here's a stub I need.

at the time afs was written it wasnt a mistake.  syscall was the only
(easy) way into the kernel from user space.  adding multiple syscalls
would have just been completely painful.  as for examples, pioctl() --
the user space of the afs syscall -- is a bit like syssgi() i am afraid:

venus/fs.c:     code = pioctl(0, VIOC_GETCELLSTATUS, &blob, 1);
venus/fs.c:    code = pioctl(0, VIOC_SETRXKCRYPT, &blob, 1);
vlserver/sascnvldb.c:   code = pioctl(ti->data, VIOCGETVOLSTAT, &blob, 1);
auth/ktc_nt.c:  code = pioctl(0, VIOCNEWGETTOK, &iob, 0);
auth/ktc_nt.c:  code = pioctl(0, VIOCDELTOK, &iob, 0);
package/package.c:  code = pioctl(0, VIOC_AFS_SYSNAME, &data, 1);
venus/up.c:          code = pioctl(file1, _VICEIOCTL(2), &blob, 1);

in reality, very few things other than afs are going to want to use
the afs syscall (arla might be a possible user).

Return-Path: <linux-kernel-owner+w=401wt.eu-S932217AbXAQJ6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbXAQJ6c (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXAQJ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:58:31 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42722 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbXAQJ6a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:58:30 -0500
Date: Wed, 17 Jan 2007 10:54:47 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-aio <linux-aio@kvack.org>,
       Bharata B Rao <bharata@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: [PATCH -mm 0/5][AIO] - AIO completion signal notification v5
Message-ID: <20070117105447.3224e426@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:46,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:47,
	Serialize complete at 17/01/2007 11:06:47
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

  Andrew, would you consider including this patchset in -mm for some more
testing. At least patches 1 - 4.


  Patch 5 is the new listio syscall approach from Bharata B Rao which is much
cleaner than overloading sys_io_submit() with a new opcode but maybe needs some
more discussion before being engraved in stone.

  I'm thinking here of having the capability to be notified when m requests
have completed (m <= total_number_of_submitted_requests) as suggested by Ulrich
Drepper.

  Ulrich, is this still something you want? In which case we may need to add
another argument to sys_lio_submit().

  Sébastien.


  This set consists in 5 patches:

	1. rework-compat-sys-io-submit: cleanup the sys_io_submit() compat layer,
	   making it more efficient and laying out the base for the following patches

	2. aio-header-fix-includes: fixes the double inclusion of uio.h in aio.h

	3. export-good_sigevent: move good_sigevent into signal.c and make it
	   non-static

	4. aio-notify-sig: the AIO completion signal notification

	5. listio: adds listio support

  Description are in the individual patches.

  Changes from v4:
	No comments received for v4, so it must be perfect ;-)
	replaced the IOCB_CMD_GROUP listio implementation with Bharata's
	syscall approach which I find much cleaner.

  Changes from v3:
	All changes following comments from Zach Brown and Christoph Hellwig

	- added justification for the compat_sys_io_submit() cleanup
	- more cleanups in compat_sys_io_submit() to put it in line with
	  sys_io_submit()
	- Changed "Export good_sigevent()" patch name to "Make good_sigevent()
	  non-static" to better describe what it does.=20
	- Reworked good_sigevent() to make it more readable.
	- Simplified the use of the SIGEV_* constants in signal notification
	- Take a reference on the target task both for the SIGEV_THREAD_ID and
	  SIGEV_SIGNAL cases.

  Changes from v2:
	- rebased to 2.6.19-rc6-mm2
	- reworked the sys_io_submit() compat layer as suggested by Zach Brown
	- fixed saving of a pointer to a task struct in aio-notify-sig as
	  pointed out by Andrew Morton

  Changes from v1:
	- cleanups suggested by Christoph Hellwig, Badari Pulavarty and
	Zach Brown
	- added listio patch

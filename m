Return-Path: <linux-kernel-owner+w=401wt.eu-S932341AbXADJU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbXADJU0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbXADJU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:20:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49411 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932339AbXADJUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:20:24 -0500
Date: Thu, 4 Jan 2007 14:57:33 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCHSET 3][PATCH 0/5][AIO] - AIO completion signal notification v4
Message-ID: <20070104092733.GD9608@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227153855.GA25898@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi

  Here is a repost of Sebastien's AIO completion signal notification v4
  patches along with the syscall based listio support patch. The goal
  of this patchset is to improve the POSIX AIO support in the kernel.

  While the 1st 4 patches provide the AIO completion signal notification
  support, the 5th one provides the listio support.

  Sebastien's original patchset had a different listio support patch
  (patch number 5) based on overloading the io_submit() with a new
  aio_lio_opcode (IOCB_CMD_GROUP). But here listio support is provided
  by a separate system call.

  As mentioned, this set consists of 5 patches:

	1. rework-compat-sys-io-submit: cleanup the sys_io_submit() compat
	layer, making it more efficient and laying out the base for the
	following patches

	2. aio-header-fix-includes: fixes the double inclusion of uio.h in aio.h

	3. export-good_sigevent: move good_sigevent into signal.c and make it
	   non-static

	4. aio-notify-sig: the AIO completion signal notification

	5. listio: adds listio support

  Description are in the individual patches.

  Original v4 post is present at http://lkml.org/lkml/2006/11/30/223

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
	- added lisio patch

Regards,
Bharata.

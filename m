Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbTFSEw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTFSEw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:52:57 -0400
Received: from palrel11.hp.com ([156.153.255.246]:47543 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265433AbTFSEw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:52:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.17644.625625.241204@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 22:06:52 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: missing bit for thread_info-next-to-task_struct patch
In-Reply-To: <20030619060059.A600@infradead.org>
References: <16113.2972.194003.930280@napali.hpl.hp.com>
	<20030619060059.A600@infradead.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Jun 2003 06:00:59 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> On Wed, Jun 18, 2003 at 06:02:20PM -0700, David Mosberger wrote:
  >> +++ b/include/linux/sched.h	Wed Jun 18 18:01:04 2003
  >> @@ -504,9 +509,10 @@
  >> */
  >> extern struct exec_domain	default_exec_domain;
  >> 
  >> -#ifndef INIT_THREAD_SIZE
  >> -# define INIT_THREAD_SIZE	2048*sizeof(long)
  >> -#endif
  >> +#ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
  >> +# ifndef INIT_THREAD_SIZE
  >> +#  define INIT_THREAD_SIZE	2048*sizeof(long)
  >> +# endif

  Christoph> This looks strange.  Either you move the ifndef INIT_THREAD_SIZE
  Christoph> outside the other ifdef or maybe remove it comepltly it it's
  Christoph> not needed otherwise..

The INIT_THREAD_SIZE cleanup can be done as a separate patch.  I don't
want to hack (and probably break) UM for no good reason.

	--david

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275031AbRJJH2o>; Wed, 10 Oct 2001 03:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275032AbRJJH2e>; Wed, 10 Oct 2001 03:28:34 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:13004 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S275031AbRJJH2T>; Wed, 10 Oct 2001 03:28:19 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Subject: madvise(MADV_WILLNEED) not for anonymous memory?
Date: Wed, 10 Oct 2001 09:29:06 +0200
Organization: Econos
Message-ID: <apt7stsvn66ter4eltsf63eeqimvcf4s95@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Looking at the 2.4.10.SuSE-3 kernel sources, it seems as if the madvise
system call with MADV_WILLNEED does not support anonymous memory:

  mm/filemap.c:

  static long madvise_willneed(struct vm_area_struct * vma,
          unsigned long start, unsigned long end)
  {
          long error = -EBADF;
          struct file * file;
          unsigned long size, rlim_rss;
          loff_t rsize;

          /* Doesn't work if there's no mapped file. */
          if (!vma->vm_file)
                  return error;

FWIW, MADV_DONTNEED (madvise_dontneed) will happily call zap_page_range
without testing for file backing.

Is there a (less intuitive) way to give the VM a hint that the data of a
mmap'ed region (e.g. "stuff that may have been swapped out") is going to
be needed?

I realize, BTW, that despite the naming DONTNEED and WILLNEED are not
orthogonal (DONTNEED according to the comment in filemap.c will
"destroy" data).

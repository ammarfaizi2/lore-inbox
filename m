Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277404AbRJVBZH>; Sun, 21 Oct 2001 21:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277409AbRJVBY5>; Sun, 21 Oct 2001 21:24:57 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:49676 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277404AbRJVBYn>; Sun, 21 Oct 2001 21:24:43 -0400
Message-ID: <3BD3747F.6893E49D@zip.com.au>
Date: Sun, 21 Oct 2001 18:21:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: ext3 0.9.13 for linux 2.4.13-pre6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ext3 patch for the latest Linus kernel is at

	http://www.uow.edu.au/~andrewm/linux/ext3/

The changes are quite small:

- Tided up some code now that quotas in Linus and -ac kernels are
  synced up.

- Fix a race which can cause a null-pointer deref in ext3_writepage().
  This bug has been there for a long time, but only manifested in
  2.3.13-pre for some reason.

I've tested this pretty hard, every which way.  It looks OK.

There was a report against ext3-for-2.4.10 that mark_buffer_clean()
was being called against an already-clean buffer.  This has not
been reproducable (in later kernels, at least).  If anyone sees
the message "jbd_preclean_buffer_check: clean of clean buffer"
come out, please shout.  This can only happen if ext3 debugging
support is enabled in config.

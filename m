Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUAIMG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 07:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUAIMG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 07:06:58 -0500
Received: from gw.openisis.org ([217.115.141.41]:1741 "HELO gw.openisis.org")
	by vger.kernel.org with SMTP id S261262AbUAIMG4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 07:06:56 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Klaus Ripke <paul@malete.org>
To: linux-kernel@vger.kernel.org
Subject: mm/filemap.c: atomic file read(2)/write(2) ?
Date: Fri, 9 Jan 2004 13:08:44 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200401091308.45802.paul@malete.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

judging from mm/filemap.c it seems like
ordinary reads/writes should be atomic to each other
(read sees write completely or not at all,
not only where it "can be proven to be after the write"),
if
- the fs uses the generic code from filemap.c,
  like ext2 and most do
- the file region affected fits within one cache page,
  like nice little B-Tree blocks do,
  so there is only one copy_from/to_user per call
- the respective userspace memory regions fit within
  one page, so the copy will not be interrupted
- we're not interfering with another processor
  (but depending on mm hardware it could even work on SMP ?)

correct?

Would be a nice property to avoid read locks on a L-B-Tree

thx + cheers
Paul

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUKHL3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUKHL3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 06:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUKHL3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 06:29:24 -0500
Received: from wpkrenn.net ([217.114.210.79]:9992 "EHLO
	217-114-210-79.wpkrenn.net") by vger.kernel.org with ESMTP
	id S261522AbUKHL3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 06:29:19 -0500
Message-ID: <418F4F97.5000805@gmx.at>
Date: Mon, 08 Nov 2004 11:51:03 +0100
From: Willibald Krenn <Willibald.Krenn@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de-AT; rv:1.4.2) Gecko/20040921
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VMM:  syscall for reordering pages in vm
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick Summary:

(Good or Bad?) Idea of implementing a syscall that allows
for virtual memory page exchange by modifying the physical<->virtual
page mapping. Intended usage: Moving pages in virtual memory without
the need to copy them. Feedback welcome!



Longer Version:

I need some advice from the Linux VMM-gurus on following idea: Suppose
a user-land program wants to re-order memory it has allocated and
suppose further that this program has done allocations in a way that the
reordering can be done by exchanging whole pages in virtual memory, as
indicated below.

Page5  Program.. (part 2)
Page4  swappedout/"free"
Page3  Program.. (part 3)
Page2  Program.. (part 4)
Page1  swappedout/"free"
Page0  Program.. (part 1)

How about implementing a system call that allows the user-program to
exchange pages? In the example above e.g. Page 5/Page 1 and
Page 3/Page 2.
As far as I understand, the system call would 'just' have to change the
physical<->virtual mapping of these pages and the exchange would be done
without having to copy -in the example above- 4*PageSize bytes in 
userland. (Of course there are some additional benefits in the given 
example, as there is no need to swap in a page as a buffer for the 
copy-operation...)


However, before investigating this idea any further, I figured it would 
be best to ask for comments from the experts here.. (I've barely any 
knowledge about the Linux-VMM and therefore my idea might be complete 
and utter nonsense.)
Any kind of feedback is greatly appreciated!


Thanks for all your time,
  Willibald Krenn


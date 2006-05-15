Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWEOVjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWEOVjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWEOVjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:39:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5794 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964858AbWEOVjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:39:22 -0400
Subject: send(), sendmsg(), sendto() not thread-safe
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
From: Mark A Smith <mark1smi@us.ibm.com>
Date: Mon, 15 May 2006 14:39:06 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF123 | April 14, 2006) at
 05/15/2006 17:39:21
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I discovered that in some cases, send(), sendmsg(), and sendto() are not
thread-safe. Although the man page for these functions does not specify
whether these functions are supposed to be thread-safe, my reading of the
POSIX/SUSv3 specification tells me that they should be. I traced the
problem to tcp_sendmsg(). I was very curious about this issue, so I wrote
up a small page to describe in more detail my findings. You can find it at:
http://www.almaden.ibm.com/cs/people/marksmith/sendmsg.html .

Thanks,
Mark A. Smith

PS. I am using the term "thread" in the general sense, this is a problem
independent of pthreads, etc. The problem occurs when two processes
(whether or not they share an address space) send on the same socket (and
some other low-resource conditions exist).


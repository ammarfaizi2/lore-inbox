Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTERTqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTERTqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:46:04 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:56333 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262176AbTERTqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:46:03 -0400
Date: Sun, 18 May 2003 21:59:13 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: need better I/O scheduler for bulk file serving
Message-ID: <20030518195913.GA19275@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing some network scalability testing on Linux.  I'm using sendfile
and epoll on non-blocking file descriptors, and I am uploading several
large files (CD images in my case) to several downloaders.

When only one peer is downloading, I get wire speed bandwidth
utilization.

When three people are downloading different images (my server "only" has
512 MB RAM, so it can't hold even one of the images in memory) at the
same time, the bandwidth utilization goes down to 6 MB/sec on my fast
ethernet NIC.  The hard disk appears to be busy seeking.

What knobs exist to tweak this?  This appears to be exactly the kind of
problem the I/O schedulers are trying to solve, right?  And the kernel
has perfect knowledge of what is going to happen because sendfile is
called with file size as length.  Larger read-ahead maybe?

Felix

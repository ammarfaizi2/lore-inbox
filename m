Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263219AbREaUrZ>; Thu, 31 May 2001 16:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbREaUrP>; Thu, 31 May 2001 16:47:15 -0400
Received: from suntan.tandem.com ([192.216.221.8]:25340 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S263219AbREaUrL>; Thu, 31 May 2001 16:47:11 -0400
Message-ID: <3B16AC35.29944B45@compaq.com>
Date: Thu, 31 May 2001 13:40:21 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fork/open race results in wasted fd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two tasks (A & B) share the same files_struct. A calls open() at the same time
as B calls fork(). After A runs get_unused_fd() but before it calls
fd_install(), B runs copy_files().

It looks like the result is one of the bits is set in B's open_fds field with no
corresponding file pointer in its fd array. The fd is unusable, and attempting
to close() it would return EBADF.

Is this a known race?

-Brian (please copy me in response)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVAGN1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVAGN1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVAGN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:27:49 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:32234 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261407AbVAGN1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:27:46 -0500
Message-ID: <41DE9D10.B33ED5E4@tv-sign.ru>
Date: Fri, 07 Jan 2005 17:30:40 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Make pipe data structure be a circular list of pages, rather than
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

pipe_writev:
> +		if (bufs < PIPE_BUFFERS) {
> +			ssize_t chars;
> +			int newbuf = (info->curbuf + bufs) & (PIPE_BUFFERS-1);

If i understand this patch correctly, then this code

	for (;;)
		write(pipe_fd, &byte, 1);

will block after writing PIPE_BUFFERS == 16 characters, no?
And pipe_inode_info will use 64K to hold 16 bytes!

Is it ok?

May be it make sense to add data to the last allocated page
until buf->len > PAGE_SIZE ?

Oleg.

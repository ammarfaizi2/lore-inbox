Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268736AbTGaUtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269204AbTGaUtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 16:49:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:51693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268736AbTGaUs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 16:48:59 -0400
Date: Thu, 31 Jul 2003 13:37:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5] reiserfs: fix races between link and unlink on
 same file
Message-Id: <20030731133708.04bcd0c9.akpm@osdl.org>
In-Reply-To: <20030731144204.GP14081@namesys.com>
References: <20030731144204.GP14081@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> This patch (originally by Chris Mason) fixes link/unlink races in reiserfs.
> 

Could you describe the race a little more please?  Why is the VFS's hold of
i_sem on the parent directory not sufficient?

> +
> +    /* 
> +     * we schedule before doing the add_save_link call, save the link
> +     * count so we don't race

This comment would seem to imply lock_kernel()-based locking, but
lock_kernel() is not held here.


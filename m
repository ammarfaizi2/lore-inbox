Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbUDSArE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUDSArE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:47:04 -0400
Received: from mail.shareable.org ([81.29.64.88]:52131 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264228AbUDSArC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:47:02 -0400
Date: Mon, 19 Apr 2004 01:46:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Nasty 2.6 sendfile() bug / regression; affects vsftpd
Message-ID: <20040419004657.GD11064@mail.shareable.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com> <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at related code, sys_sendfile64 a few lines down.

	if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
		return -EFAULT;

	if (unlikely(put_user(pos, offset)))
		return -EFAULT;

It seems odd that put_user() is used to write an 8-byte value, but
get_user() cannot be used read one.  I looked in <asm-i386/uaccess.h>
and indeed the asymmetry is there.

Is there a reason why put_user() supports 1/2/4/8 bytes and get_user()
supports only 1/2/4 bytes?

-- Jamie

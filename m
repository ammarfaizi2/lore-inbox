Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTGWOKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbTGWOKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:10:20 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:27384 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270326AbTGWOKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:10:16 -0400
Subject: Re: kernel bug in socketpair()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Korn <dgk@research.att.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gsf@research.att.com
In-Reply-To: <200307231332.JAA26197@raptor.research.att.com>
References: <200307231332.JAA26197@raptor.research.att.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058970007.5520.68.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 15:20:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 14:32, David Korn wrote:
> The first problem is that files created with socketpair() are not accessible
> via /dev/fd/n or /proc/$$/fd/n where n is the file descriptor returned
> by socketpair().  Note that this is not a problem with pipe().

This is intentional - sockets do not have an "open" operation currently.

> The second problem is that if fchmod(fd,S_IWUSR) is applied to the write end
> of a pipe(),  it causes the read() end to also be write only so that
> opening  /dev/fd/n for read fails.


That doesn't directly suprise me. Our pipes are BSD style not streams
pipes. One thing that means is that the pipe itself is a single inode.


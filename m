Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTIVVyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTIVVyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:54:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43649 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262797AbTIVVyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:54:44 -0400
Date: Mon, 22 Sep 2003 22:54:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922215432.GE29869@mail.jlokier.co.uk>
References: <20030922153651.16497.qmail@science.horizon.com> <m1brtck6wq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1brtck6wq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:
> > So can we gradually kill inb_p, outb_p in 2.6?  An the other
> > miscellaneous users of I/O port 0x80 for I/O delays?
> 
> Actually, It's not easy.  The issue got debated a lot a few years ago.
> A read is also acceptable, and allows a few more ports to be
> potentially used, but that corrupts %al and thus bloats the code.

It bloats the code a lot less than udelay() calls or any other
solution which keeps the delay!

In the worst case, the bloat from a read _should_ be two bytes: "push
%eax; inb $80,%al; pop %eax".  Whereas a call to udelay is 5 bytes,
for a call instruction.

-- Jamie

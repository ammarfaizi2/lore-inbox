Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbUDFSRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUDFSRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:17:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:3988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263935AbUDFSQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:16:26 -0400
Date: Tue, 6 Apr 2004 11:16:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: ankry@green.mif.pg.gda.pl, linux-kernel@vger.kernel.org
Subject: Re: PTS alocation problem with 2.6.4/2.6.5
Message-Id: <20040406111604.224f20b5.akpm@osdl.org>
In-Reply-To: <20040406175501.GA27672@mail.shareable.org>
References: <200404052253.i35Mr6k6011170@green.mif.pg.gda.pl>
	<20040405165957.5f8ab8dc.akpm@osdl.org>
	<20040406175501.GA27672@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Andrew Morton wrote:
> > You need a glibc upgrade - we broke things for really old glibc's.  We're
> > (slowly) working on fixing it up.
> 
> Looking at patch-2.6.4, there are plenty of minor changes to the pty
> code but nothing that looks like it would break userspace except for
> _very_ old glibcs that don't know about /dev/pts at all and just used
> the legacy ones.
> 
> I have some _non-glibc_ pty code that I wish to keep working.  Can you
> briefly explain how it breaks with moderately old glibcs such as the
> glibc-2.3.3 that's said to be inadequate, and therefore what interface
> change is needed in non-glibc code?
> 

Andrzej is using a glibc that "does not support minors > 255".

The oldest glibc I have around here is glibc-2.2.5-34 and it passes
Andrzej's `for a in $(seq 4);do ssh -t remote tty;done' test OK.  I do not
know at which version they started to permit larger values for minors, but
it must have been some time ago.

A small number of people are hurting from the removal of first-fit pty
allocation and I do think it needs to be put back.  I have a patch but
neither Peter nor I have actually tested it yet.  I'll aim to get it into
2.6.6.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTDNTix (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTDNTiw (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:38:52 -0400
Received: from fmr03.intel.com ([143.183.121.5]:28137 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263718AbTDNTiv convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:38:51 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBADA1@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Bryan Shumsky'" <bzs@via.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Memory mapped files question
Date: Mon, 14 Apr 2003 12:50:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Bryan Shumsky [mailto:bzs@via.com]
> 
> Hi, everyone.  Thanks for all your responses.  Our confusion is that in
Unix
> environments, when we modify memory in memory-mapped files the underlying
> system flusher manages to flush the files for us before the files are
> munmap'ed or msysnc'ed.
> 
> Rewriting all of our code to manually handle the flushing is a MAJOR
> undertaking, so I was hoping there might be some sneaky solution you could
> come up with.  Any ideas?

Have a high prio thread msync()ing every now and then? OOps forget it,
I never said that, it is really a lame solution :) you can run in all
kinds of trouble.

Or maybe it is not that lame if you know *exactly* when do you need
the flush (for example, some other program is going to access the data);
this way you can signal the process who did the modification for it
to issue an msync(). However, this is going to be some delicate
synchronization
between the two apps.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

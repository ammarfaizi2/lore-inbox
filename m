Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTDNT7j (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTDNT7j (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:59:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3467 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263862AbTDNT7e (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:59:34 -0400
Date: Mon, 14 Apr 2003 16:13:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bryan Shumsky <bzs@via.com>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
In-Reply-To: <004301c302bd$ed548680$fe64a8c0@webserver>
Message-ID: <Pine.LNX.4.53.0304141559140.28851@chaos>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com>
 <004301c302bd$ed548680$fe64a8c0@webserver>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Bryan Shumsky wrote:

> Hi, everyone.  Thanks for all your responses.  Our confusion is that in Unix
> environments, when we modify memory in memory-mapped files the underlying
> system flusher manages to flush the files for us before the files are
> munmap'ed or msysnc'ed.
>

So? Why should you care?

> Rewriting all of our code to manually handle the flushing is a MAJOR
> undertaking, so I was hoping there might be some sneaky solution you could
> come up with.  Any ideas?
>
> Thanks again,
>

Memory mapped files are supposed to be accessed through memory!
Any program that needs to know what's on the physical disk is
broken. If you need to write to files and know when they are
written to the physical media, you use a journaled file-system.

Anytime you write to a memory mapped file, anybody else who
also mapped that file will see the changes as long as the file
was mapped MAP_SHARED. If your program mapped it MAP_PRIVATE, it's
probably broken.

There is nothing to work-around. All working databases work
this way.

Memory mapped files are used to speed access to large files. Only
the portion of the file actually being accessed needs to be resident
in memory. Multiple readers and writers can access these memory-
mapped portions without enduring the time for long seeks to various
pieces of the file. The snippets of the file get written to the
media using a LRU (least recently used) mechanism so that stuff that
isn't being actively updated is the stuff that gets written to the
device (actually replaced with something that needs to be accessed).
Therefore, there is absolutely no possible way for this interchange
to be somehow handled by the user. It doesn't happen in any memory-
mapped file --ever.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUCBPFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUCBPFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:05:15 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:49811 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261669AbUCBPFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:05:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 2 Mar 2004 07:05:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben <linux-kernel-junk-email@slimyhorror.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: epoll and fork()
In-Reply-To: <20040302050233.3b33188b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0403020654080.24044-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Is there a defined behaviour for what happens when a process with an epoll
> fd forks?
> 
> I've an app that inherits an epoll fd from its parent, and then
> unregisters some file descriptors from the epoll set. This seems to have
> the nasty side effect of unregistering the same file descriptors from the
> parent process as well. Surely this can't be right?

epoll does register the underlying file* not the fd, so this is the 
expected behaviour. Inheriting an fd, and epoll is no exception, simply 
bumps a counter, so both parent and child epoll fd shares the same context. 
Sorry but what behaviour do you expect by unregistering an fd pushed by 
the parent from inside a child? Events work exactly the same. Since the 
context is shared, events are delivered only once.



- Davide



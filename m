Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTJ1Pib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264003AbTJ1Pib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:38:31 -0500
Received: from [204.178.40.224] ([204.178.40.224]:35981 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264002AbTJ1Pia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:38:30 -0500
Date: Tue, 28 Oct 2003 10:39:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Amir Hermelin <amir@montilio.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: how do file-mapped (mmapped) pages become dirty?
In-Reply-To: <006901c39d50$0b1313d0$2501a8c0@CARTMAN>
Message-ID: <Pine.LNX.4.53.0310281035040.21561@chaos>
References: <006901c39d50$0b1313d0$2501a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003, Amir Hermelin wrote:

> Hi,
> When a process mmaps a file, how does the kernel know the memory has been
> written to (and hence the page is dirty)? Is this done by setting the

This is automatically done by the CPU (no overhead) with Intel
CPUs.

> protected flag, and when the memory is first written to it's set to dirty?
> What function is responsible for this setting? And when will the page be
> written back to disk (i.e. where's the flusher located)?
>

If you start to run low on memory, the disk buffer(s) may be flushed
to the hardware. Otherwise, you need an explicit fsync() or a close().

Any reads by others will always show updated changes. You don't
need to do anything special.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



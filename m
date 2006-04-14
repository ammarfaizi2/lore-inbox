Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWDNQsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWDNQsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWDNQsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:48:14 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:8624 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751278AbWDNQsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:48:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ct10Nex9+nM/qo7ljQCkOU2YLm9hdcqglv2cc4WSGrXQ6btzec+IHQYRqM3lR/1P0H67JkObZ0VuFOc4e/DbwwStTdzOZZbG2l0M8z40Z3riEcTb6MPVgvqYUcuCr0AwFlGhLGWLnoBhOpNTU0NRsr8D2DemquL7MrIxlxu6KJU=
Message-ID: <d4b6d3ea0604140948l36c8048ha819a6611c8fdad3@mail.gmail.com>
Date: Fri, 14 Apr 2006 09:48:13 -0700
From: "Michael Madore" <michael.madore@gmail.com>
To: discuss@amd64.org
Subject: Lockup/reboots on multiple dual core Opteron systems
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have several dozen systems based on the AMD 8111/8131 chipset which
are experiencing lockups or reboots while under heavy stress.  All
systems are configured identically:

(2) dual core Opteron 285 processors
8 GB RAM
1 IDE hard disk

When the lockup occurs, there is no information printed to the screen,
and magic sysrq does not work.   The systems will often lockup within
a matter of hours, but sometimes they can run for several days before
locking up.

The testing involves:

1) Allocate several GB of memory from each node and read/write to it.
2) Perform lots of disk I/O
3) Keep all cores busy

I see the lockup no matter which kernel I try:

2.6.5 (SLES 9)
2.6.9 (RHEL 4)
2.6.16 (kernel.org)

The systems will run perfectly stable under the following conditions:

1) Use a 32-bit kernel
or
2) Boot 64-bit kernel with mem=3000M
or
3) Don't perform any disk I/O during the test

I have also tested the dual core 8GB combination on both NForce and
Serverworks based motherboards with the same results.  In this case
both systems were using SATA hard disks instead of IDE.

Any ideas what the culprit could be?

Mike

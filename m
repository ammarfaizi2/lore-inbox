Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUJCUos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUJCUos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUJCUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:44:48 -0400
Received: from pat.uio.no ([129.240.130.16]:36250 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268141AbUJCUom convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:44:42 -0400
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, iwamoto@valinux.co.jp,
       haveblue@us.ibm.com, Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       piggin@cyberone.com.au, arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041004.050320.78713249.taka@valinux.co.jp>
References: <20041003140723.GD4635@logos.cnet>
	 <20041004.033559.71092746.taka@valinux.co.jp>
	 <1096831287.9667.61.camel@lade.trondhjem.org>
	 <20041004.050320.78713249.taka@valinux.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096836249.9667.100.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 22:44:09 +0200
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 03/10/2004 klokka 22:03, skreiv Hirokazu Takahashi:

> However, while network is down network/cluster filesystems might not
> release pages forever unlike in the case of block devices, which may
> timeout or returns a error in case of failure.

Where is the difference? As far as the VM is concerned, it is a latency
problem. The fact of whether or not it is a permanent hang, a hang with
a long timeout, or just a slow device is irrelevant because the VM
doesn't actually know about these devices.

> Each filesystem can control what the migration code does.
> If it doesn't have anything to help memory migration, it's possible
> to wait for the network coming up before starting memory migration,
> or give up it if the network happen to be down. That's no problem.

Wrong. It *is* a problem: Filesystems aren't required to know anything
about the particulars of the underlying block/network/... device timeout
semantics either.

Think, for instance about EXT2. Where in the current code do you see
that it is required to detect that it is running on top of something
like the NBD device? Where does it figure out what the latencies of this
device is?

AFAICS, most filesystems in linux/fs/* have no knowledge whatsoever
about the underlying block/network/... devices and their timeout values.
Basing your decision about whether or not you need to manage high
latency situations just by inspecting the filesystem type is therefore
not going to give very reliable results.

Cheers,
  Trond


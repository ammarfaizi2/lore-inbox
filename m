Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUB0GU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUB0GU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:20:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26887 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261692AbUB0GUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:20:53 -0500
Date: Fri, 27 Feb 2004 07:12:20 +0100
From: Willy Tarreau <willy@w.ods.org>
To: MP M <mageshmp2003@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: help in TCP checksum offload , TSO and zero copy
Message-ID: <20040227061220.GC7785@alpha.home.local>
References: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 10:52:19AM -0800, MP M wrote:
> ttcp-t: 216442880 bytes in 299.34 real seconds =
> 706.13 KB/sec +++
^^^^^^^^^

It's obvious that you have other problems, because lack of hardware
checksum won't lead to such abysmal performance. You should start
with *real* traffic, and not with I/O bound tools such as tar.
For instance, you'd better use "dd if=/dev/zero bs=64k count=4000"
(or use /dev/urandom) to generate some data if you absolutely need
some. But here, I'm fairly certain that your disk is *THE* problem.
I could easily reach the Gb/s with a P3/1G on a crappy dl2k, so I
don't see why you could not to it on better hardware.

Oh, and BTW, check your cable (netstat -i) to see if you get drops
or errors. You can also have poor wires which lead to frequent
retransmits. GigE uses all 4 pairs (8 wires), so a cable which
works well on FastEth is not necessarily OK on GigE.

Cheers,
Willy


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUHXFuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUHXFuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266507AbUHXFuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:50:20 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:34487 "EHLO
	server.home") by vger.kernel.org with ESMTP id S266133AbUHXFuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:50:14 -0400
Date: Mon, 23 Aug 2004 22:49:31 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Christoph Lameter <clameter@sgi.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu
Subject: Re: page fault scalability patch v3: use cmpxchg, make rss atomic
In-Reply-To: <Pine.LNX.4.58.0408232138540.32721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0408232243530.26785@server.home>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
 <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
 <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408232138540.32721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Christoph Lameter wrote:

> Issue remaining:
> - Figure out why performance drops for single thread.

Sorry, wrong baseline... There is no issue here except using a 2GB
test against a 4GB one.

Unpatched:
Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4   3    1    0.157s     11.197s  11.035s 69261.721  69239.940
  4   3    2    0.145s     11.445s   6.079s 67849.528 115681.409
  4   3    4    0.182s     13.894s   4.027s 55865.834 184108.856
  4   3    8    0.196s     24.874s   4.025s 31369.039 184790.767

With page fault scalability patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  4   3    1    0.176s     11.323s  11.050s 68385.368  68345.055
  4   3    2    0.174s     10.716s   5.096s 72205.329 131848.322
  4   3    4    0.170s     10.694s   3.040s 72380.552 231128.569
  4   3    8    0.177s     14.717s   2.064s 52796.567 297380.041

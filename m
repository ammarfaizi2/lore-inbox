Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUG2AZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUG2AZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUG2AY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:24:56 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:30629 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267383AbUG2AYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:24:32 -0400
Date: Wed, 28 Jul 2004 17:24:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: peter@chubb.wattle.id.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-ID: <20040729002413.GA30647@taniwha.stupidest.org>
References: <233602095@toto.iv> <16648.10711.200049.616183@wombat.chubb.wattle.id.au> <20040728154523.20713ef1.davem@redhat.com> <20040729000837.GA24956@taniwha.stupidest.org> <20040728171414.5de8da96.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728171414.5de8da96.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 05:14:14PM -0700, David S. Miller wrote:

> Run "time find . -type f" on the kernel tree, both before and
> after removing the third unnecessary copy.  Many machines sit all
> day and stat files.

On an old crappy ia32 machine:

    cw@taniwha:~/wk/linux/cw-current$ time find . -noleaf | wc
      42372   42372 1549653

    real    0m0.188s
    user    0m0.042s
    sys     0m0.146s

that 0.2s to make almost 50K stat64 calls (if you strace and grep you
can see that count).

Since I have to do something with that data (ie. build a kernel) and
that's *probably* going to take many seconds, even making the stat
overhead 0 wouldn't put much of dent into the overall time.

What am I missing?


  --cw

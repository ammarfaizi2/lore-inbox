Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266380AbUG0P5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUG0P5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUG0P5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:57:19 -0400
Received: from holomorphy.com ([207.189.100.168]:20100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266380AbUG0P5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:57:18 -0400
Date: Tue, 27 Jul 2004 08:57:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 4K stack overflow
Message-ID: <20040727155715.GD2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux@horizon.com, linux-kernel@vger.kernel.org
References: <20040727074813.4596.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727074813.4596.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 07:48:13AM -0000, linux@horizon.com wrote:
> Just a crash report.  Machine locked hard - no caps lock, no ping.
> Machine mostly idle.  Amanda network backup was running, but not daily cron.
> Backtrace copied by hand. (I didn't copy the leading addresses.)
> FWIW, only one partition (a RAID-0 non-critical data partition) is
> mounted with ext2.
> .config follows.  Compiler is GCC 3.3.4 (Debian 3.3.4-3)  Hardware is
> Intel Celeron, 440BX motherboard.
> Hopefully it helps someone.  I don't have frame pointers enabled, so I
> assume the confusing bits of the backtrace are clutter misidentified as
> a return address.

It looks like you took invalid opcode exceptions in addition to some
rather suspicious oopsen in/around buffered_rmqueue(). The latter are
likely stack gunk, the former OTOH I suspect may be real.

Could you try to reproduce without CONFIG_REGPARM and turn on frame
pointers? Might help a bit to cut down on ways backtraces might get
misinterpreted.


-- wli

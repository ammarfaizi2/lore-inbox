Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbUBZQ3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbUBZQZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:25:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25607 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262811AbUBZQY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:24:56 -0500
Date: Thu, 26 Feb 2004 17:16:37 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG][2.4] /proc/kcore is a random generator ?
Message-ID: <20040226161637.GA4201@alpha.home.local>
References: <200402181337.i1IDbsXU010467@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402181337.i1IDbsXU010467@hera.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm encountering a rather strange behaviour here with 2.4.25 on a P4 HT,
even when I boot it with "nosmp" :
  - du /proc/kcore says '525255' (I have 512 MB RAM)
  - if I do it again many several times, sometimes it says '0'
  - after a moment (or several tests, I don't know), it stabilizes to some
    value (either 0 or 525255).
  - then, just starting vmstat, or logging into the system is enough to
    make it switch to the other value.

At first, I had the feeling that it displayed '0' when I have an even number
of processes, and 525255 when I have an odd number, but it's not even the case.
Once it doesn't move by itself, a few fork/exec are enough to switch the value.

If I boot in HT mode, sometimes I can reliably make it display 0 and 525255
alternatively, just as if the pid parity or CPU number was involved in the
result.

Update: same results with 2.4.26-pre1. du from coreutils 4.5.4 and 5.0.

This is amazing. Did anyone notice this ? A friend just told me that plain
2.4.22 on his notebook does the same !

Regards,
Willy


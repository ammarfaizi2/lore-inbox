Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVCWN6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVCWN6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:58:20 -0500
Received: from duempel.org ([81.209.165.42]:50375 "HELO swift.roonstrasse.net")
	by vger.kernel.org with SMTP id S261468AbVCWNyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:54:02 -0500
Date: Wed, 23 Mar 2005 14:53:17 +0100
From: Max Kellermann <max@duempel.org>
To: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050323135317.GA22959@roonstrasse.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll> <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/03/22 12:49, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> What if the few procs that he may spawn also grab so much memory so
> your machine disappears in swap-t(h)rashing?

The number of processes is counted per user, but CPU time and memory
consumption is counted per process.

Going around RLIMIT_CPU is too easy by simply forkbombing. This
renders RLIMIT_CPU unusable.

The memory limits aren't good enough either: if you set them low
enough that memory-forkbombs are unperilous for
RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
applications.

Now what about per-user (or per-session) CPU and memory limits?

Another idea: RLIMIT_FORK (number of allowed fork() calls in that
session). While that may not be useful for interactive login sessions,
I can imagine several situations where it could help (like qmail child
processes).

Max


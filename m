Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVCWO5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVCWO5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVCWO5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:57:49 -0500
Received: from duempel.org ([81.209.165.42]:57799 "HELO swift.roonstrasse.net")
	by vger.kernel.org with SMTP id S262668AbVCWOwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:52:49 -0500
Date: Wed, 23 Mar 2005 15:52:04 +0100
From: Max Kellermann <max@duempel.org>
To: Natanael Copa <mlists@tanael.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050323145204.GA23661@roonstrasse.net>
Mail-Followup-To: Natanael Copa <mlists@tanael.org>,
	linux-kernel@vger.kernel.org
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll> <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr> <20050323135317.GA22959@roonstrasse.net> <1111587814.27969.86.camel@nc> <20050323142753.GA23454@roonstrasse.net> <1111589098.27969.100.camel@nc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111589098.27969.100.camel@nc>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/03/23 15:44, Natanael Copa <mlists@tanael.org> wrote:
> Yes, but if 
> RLIMIT_NPROC is per user and RLIMIT_CPU is per proc
> 
> the theoretical CPU limit per user is RLIMIT_NPROC * RLIMIT_CPU. So if
> you half the RLIMIT_NPROC you will half the theoretical maximum CPU
> limit per user.
> 
> Same with memory.

It's even worse with RLIMIT_CPU. Imagine a process forks
RLIMIT_NPROC-1 child processes. These consume all their CPU time, get
killed with SIGXCPU, and the parent process spawns new child processes
again with fresh RLIMIT_CPU counters (the parent process idled
meanwhile, consuming none of its assigned CPU cycles). Again and
again.

You see, RLIMIT_CPU is worthless in its current implementation.

Max


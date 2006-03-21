Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWCUOyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWCUOyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWCUOyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:54:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36578 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751748AbWCUOyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:54:08 -0500
Date: Tue, 21 Mar 2006 15:52:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321145202.GA3268@elte.hu>
References: <1142592375.7895.43.camel@homer> <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer> <200603220130.34424.kernel@kolivas.org> <20060321143240.GA310@elte.hu> <20060321144410.GE26171@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321144410.GE26171@w.ods.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Willy Tarreau <willy@w.ods.org> wrote:

> Ah no, I never use those montruous environments ! xterm is already 
> heavy. [...]

[ offtopic note: gnome-terminal developers claim some massive speedups
  in Gnome 2.14, and my experiments on Fedora rawhide seem to 
  corraborate that - gnome-term is now faster (for me) than xterm. ]

> [...] don't you remember, we found that doing "ls" in an xterm was 
> waking the xterm process for every single line, which in turn woke the 
> X server for a one-line scroll, while adding the "|cat" acted like a 
> buffer with batched scrolls. Newer xterms have been improved to 
> trigger jump scroll earlier and don't exhibit this behaviour even on 
> non-patched kernels. However, sshd still shows the same problem IMHO.

yeah. The "|cat" changes the workload, which gets rated by the scheduler 
differently. Such artifacts are inevitable once interactivity heuristics 
are strong enough to significantly distort the equal sharing of CPU 
time.

	Ingo

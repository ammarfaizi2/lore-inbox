Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVAOJao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVAOJao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 04:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVAOJan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 04:30:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:36263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVAOJaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 04:30:35 -0500
Date: Sat, 15 Jan 2005 01:30:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: matthias@corelatus.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
Message-Id: <20050115013013.1b3af366.akpm@osdl.org>
In-Reply-To: <16872.55357.771948.196757@antilipe.corelatus.se>
References: <16872.55357.771948.196757@antilipe.corelatus.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Lang <matthias@corelatus.se> wrote:
>
> The linux implementation of setitimer() doesn't behave quite as
>  expected. I found several problems:
> 
>    1. POSIX says that negative times should cause setitimer() to 
>       return -1 and set errno to EINVAL. In linux, the call succeeds.
> 
>    2. POSIX says that time values with usec >= 1000000 should
>       cause the same behaviour. In linux, the call succeeds.
> 
>    3. If large time values are given, linux quietly truncates them
>       to the maximum time representable in jiffies. On 2.4.4 on PPC,
>       that's about 248 days. On 2.6.10 on x86, that's about 24 days.
> 
>       POSIX doesn't really say what to do in this case, but looking at
>       established practice, i.e. "what BSD does", since the call comes 
>       from BSD, *BSD returns -1 if the time is out of range.
> 

These are things we probably cannot change now.  All three are arguably
sensible behaviour and do satisfy the principle of least surprise.  So
there may be apps out there which will break if we "fix" these things.

If the kernel version was 2.7.0 then well maybe...

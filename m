Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWDMJ4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWDMJ4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWDMJ4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:56:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbWDMJ4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:56:19 -0400
Date: Thu, 13 Apr 2006 02:56:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dan Bonachea <bonachead@comcast.net>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, torvalds@osdl.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Message-Id: <20060413025608.3edbf603.akpm@osdl.org>
In-Reply-To: <6.2.5.6.2.20060413015645.033d3fc8@comcast.net>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
	<20060412214613.404cf49f.akpm@osdl.org>
	<6.2.5.6.2.20060413015645.033d3fc8@comcast.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Bonachea <bonachead@comcast.net> wrote:
>
> This problem arose in the parallel runtime system for a scientific language 
>  compiler (nearly a million lines of code total - definitely a "real-world" 
>  program) - the example code is merely a pared-down demonstration of the 
>  problem. In parallel scientific computing, it's very common for many threads 
>  to be writing to stdout (usually for monitoring purposes) and it's expected 
>  and normal for output from separate threads to be arbitrarily interleaved, but 
>  it's *not* ok for output to be lost entirely. This is essentially equivalent 
>  to the real-world example you gave of many threads logging to a file.

Interesting - afaik that's the first time this has been hit in a real
application.

>  We've worked around the problem in Linux 2.6 by adding locking at user-level 
>  around our writes, as you suggest, although this of course penalizes our 
>  performance on kernels that already correctly implement the thread-safety 
>  required by the POSIX spec. In any case it seemed like a problem that we 
>  should report, to be good open-source citizens - especially given that it 
>  appears to be a regression with respect to the Linux 2.4 kernel. How you 
>  choose to handle the report is of course your decision.

yup, thanks.

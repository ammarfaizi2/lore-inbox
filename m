Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161618AbWJaEBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161618AbWJaEBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161620AbWJaEBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:01:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62637 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161618AbWJaEBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:01:00 -0500
Date: Mon, 30 Oct 2006 20:00:53 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow a larger buffer for writes to cpuset files
Message-Id: <20061030200053.f9836cce.pj@sgi.com>
In-Reply-To: <6599ad830610301838i65a00d85g82647435ea4581a4@mail.gmail.com>
References: <6599ad830610301838i65a00d85g82647435ea4581a4@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> @@ -1292,7 +1292,7 @@ static ssize_t cpuset_common_file_write(
>  	int retval = 0;
> 
>  	/* Crude upper limit on largest legitimate cpulist user might write. */
> -	if (nbytes > 100 + 6 * NR_CPUS)
> +	if (nbytes >= PAGE_SIZE)

On a system with 4 Kbyte pages, this imposes a tighter limit
if NR_CPUS is > 666.

On a system with 16 Kbyte pages, this imposes a tighter limit
if NR_CPUS is > 2714.

Those CPU counts don't look that futuristic to me.

And it makes the limit more aribitrary ... like what the heck does
that check have to do with PAGE_SIZE ?

How about coding for the possibility that either NR_CPUS or MAX_NUMNODES
is larger, and removing 'cpu' from the comment:

	/* Crude upper limit on largest legitimate list user might write. */
	if (nbytes > 100 + 6 * max(NR_CPUS, MAX_NUMNODES))

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

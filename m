Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUAHKRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUAHKRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:17:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:49131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263880AbUAHKRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:17:04 -0500
Date: Thu, 8 Jan 2004 02:16:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-Id: <20040108021637.15d1b33a.akpm@osdl.org>
In-Reply-To: <20040108105427.E20265@fi.muni.cz>
References: <20040107023042.710ebff3.akpm@osdl.org>
	<20040107215240.GA768@frodo>
	<20040108105427.E20265@fi.muni.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> wrote:
>
> Nathan Scott wrote:
>  : On Wed, Jan 07, 2004 at 02:30:42AM -0800, Andrew Morton wrote:
>  : > 
>  : > Nathan, did anything change in XFS which might explain this?
>  : 
>  : Just been back through the revision history, and thats a definate
>  : "no" - very little changed in 2.6 XFS while the big 2.6 freeze was
>  : on, and since then too (he says, busily preparing a merge tree).
>  : 
>  : > I see XFS has some private readahead code.   Anything change there?
>  : 
>  : No, and that readahead code is used for metadata only - for file data
>  : we're making use of the generic IO path code.
>  : 
>  	I have done further testing:
> 
>  - this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
>  	appear again (high load, system slow has hell), booting back
>  	to -test7 makes it disappear.

Is the CPU load higher than normal?  Excluding I/O wait?  If so, can you
profile the kernel while the load is running?

- boot with `profile=1' on the kernel command line

- establish steady state load

- Run readprofile -r

- sleep 120

- readprofile -n -v -m System.map | sort -n +2 | tail -40

(More info in Documentation/basic_profiling.txt)

Thanks.
x

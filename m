Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUAHCPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUAHCPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:15:45 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:65332 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263468AbUAHCPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:15:43 -0500
Date: Wed, 7 Jan 2004 18:16:55 -0800
From: Paul Jackson <pj@sgi.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: reduce cpumask digit grouping from 8 to 4
Message-Id: <20040107181655.74451845.pj@sgi.com>
In-Reply-To: <20040107171142.GA11525@rudolph.ccur.com>
References: <20040107171142.GA11525@rudolph.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe proposed changing mask displays from 8 to 4 chars:
-	u32 *wordp = (u32 *)maskp;
-	int i = maskbytes/sizeof(u32) - 1;
+	u16 *wordp = (u16 *)maskp;
+	int i = maskbytes/sizeof(u16) - 1;


Please don't apply this proposed patch as it stands.

It changes the output, without touching the input side (where the kernel
parses ascii masks from userland).  The in and out formats should be the
same.  See the other u32 appearances in this same file, mask.c, for the
other places that would need to be changed.

And I'd like to see a bit of a consensus for such a format change,
especially, in this case, from developers of systems with NR_CPUS in the
range of 17 to 32, who would go from a single ascii hex word to a
comma-separated double word with this change.  My hunch is that they
would prefer not to make this proposed format change.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

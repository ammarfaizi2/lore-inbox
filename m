Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUEZUiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUEZUiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUEZUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:38:06 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:12721 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265792AbUEZUh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:37:57 -0400
Date: Thu, 27 May 2004 06:37:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: dag@bakke.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
Message-ID: <20040527063740.A832024@wobbly.melbourne.sgi.com>
References: <20040526091315.17983.h012.c000.wm@mail.bakke.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040526091315.17983.h012.c000.wm@mail.bakke.com.criticalpath.net>; from dag@bakke.com on Wed, May 26, 2004 at 09:13:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Dag,

On Wed, May 26, 2004 at 09:13:14AM -0700, dag@bakke.com wrote:
> 
> I experience hangs with xfsdump, when dumping my rootfs to a USB 2.0
> connected drive. The hangs are reproducible within 0.2-2 GB of dump, and
> always come together with one or two instances of :
> 
> pagebuf_get: failed to lookup pages
> 
>  xfssyncd      S C04F25E0     0   331      1           342   317 (L-TLB)
>  cfccbf9c 00000046 c1370610 c04f25e0 cfc31d60 c0238bec cfc31d98 c04fecd8 
>  00000031 00000000 cfccbfb0 00002773 37e96cbf 00000210 c13707b8 000a43c5 
>  cfccbfb0 00000000 00000000 c03d2ec3 cfccbfb0 000a43c5 00000000 c048e508 
>  Call Trace:
>  [<c0238bec>] pagebuf_rele+0x2c/0x120
>  [<c03d2ec3>] schedule_timeout+0x63/0xc0
>  [<c0121110>] process_timeout+0x0/0x10
>  [<c023f5e7>] xfssyncd+0x57/0xc0
>  [<c023f590>] xfssyncd+0x0/0xc0
>  [<c0103f4d>] kernel_thread_helper+0x5/0x18
>  
> Anyone?
> 

This looks like the result of an earlier error on the code
path at that initial warning there (known problem) - in the
current code there is a situation where we attempt metadata
readahead, cannot initialise a XFS buffer completely due to
low memory, but fail to correctly tear down that partially
created buffer when passing back the (recoverable) error.
We're working on a fix.

cheers.

-- 
Nathan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVCMTfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVCMTfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCMTfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:35:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:53387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVCMTf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:35:28 -0500
Date: Sun, 13 Mar 2005 11:35:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: cherry@osdl.org, linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: IA32 (2.6.11 - 2005-03-12.16.00) - 56 New warnings
Message-Id: <20050313113500.59e57a87.akpm@osdl.org>
In-Reply-To: <20050313124333.GA26569@linuxtv.org>
References: <200503130508.j2D58jTQ014587@ibm-f.pdx.osdl.net>
	<20050313124333.GA26569@linuxtv.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> wrote:
>
>  On Sat, Mar 12, 2005 at 09:08:45PM -0800, John Cherry wrote:
>  > drivers/media/dvb/frontends/dvb-pll.c:104: warning: (near initialization for `dvb_pll_unknown_1.entries')
>  > drivers/media/dvb/frontends/dvb-pll.c:104: warning: excess elements in array initializer
>  > drivers/media/dvb/frontends/dvb-pll.c:105: warning: (near initialization for `dvb_pll_unknown_1.entries')
>  > drivers/media/dvb/frontends/dvb-pll.c:105: warning: excess elements in array initializer
>  [snip]
> 
>  Gerd's original patch had
> 
>  	struct dvb_pll_desc {
>  		char *name;
>  		u32  min;
>  		u32  max;
>  		void (*setbw)(u8 *buf, int bandwidth);
>  		int  count;
>  		struct {
>  			u32 limit;
>  			u32 offset;
>  			u32 stepsize;
>  			u8  cb1;
>  			u8  cb2;
>  		} entries[];
>  	};
> 
>  while 2.6.11-mm3 changed it into entries[0].

The original code failed to compile with gcc-2.95.4, so I stuck the [0] in
there, then was vaguely surprised when no warnings came out.  Seems that
later compilers _do_ warn.

I guess we could put a 9 in there.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbUKQT1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUKQT1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUKQT0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:26:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:53174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262408AbUKQTXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:23:47 -0500
Date: Wed, 17 Nov 2004 11:22:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: kraxel@bytesex.org, jelle@foks.8m.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cx88: fix printk arg. type
Message-Id: <20041117112205.7272d362.akpm@osdl.org>
In-Reply-To: <419B8EC0.2070005@osdl.org>
References: <419A89A3.90903@osdl.org>
	<20041117172519.GB8176@bytesex>
	<419B8EC0.2070005@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Gerd Knorr wrote:
>  >>-		dprintk(0, "ERROR: Firmware size mismatch (have %ld, expected %d)\n",
>  >>+		dprintk(0, "ERROR: Firmware size mismatch (have %Zd, expected %d)\n",
>  > 
>  > 
>  > Thanks, merged to cvs.  I like that 'Z'.  Or is that just a linux-kernel
>  > printk specific thingy?  Or is this standardized somewhere?  So I could
>  > use that in userspace code as well maybe?
> 
>  Kernel supports/allows 'Z' or 'z'.
>  C99 spec defines 'z' only as a size_t format length modifier:
> 
>  z   Specifies that a following d, i, o, u, x, or X conversion 
>  specifier applies to a size_t or the corresponding signed integer type 
>  argument; or that a following n conversion specifier applies to a 
>  pointer to a signed integer type corresponding to size_t argument.
> 
>  Anyway, I agree with Al.  Will you please change it to
>  'z' instead of 'Z'?

gcc-2.95.x generates warnings for `z', but is happy with 'Z'.

But I seem to be the only person who uses 2.95, and I patched my version to
stop that warning anyway, so...

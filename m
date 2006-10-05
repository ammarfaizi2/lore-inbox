Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWJEDuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWJEDuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWJEDuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:50:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750968AbWJEDuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:50:17 -0400
Date: Wed, 4 Oct 2006 20:50:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: balance dirty pages
Message-Id: <20061004205013.0b8a00bb.akpm@osdl.org>
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC3F3FD1@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC3F3FD1@mssmsx411>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 04:03:35 +0400
"Ananiev, Leonid I" <leonid.i.ananiev@intel.com> wrote:

> The throughput of iozone benchmark is changed as
>  
>             serial          random
> write    -55%         -99% 
> read     +60%       +13%
>  
> after "[PATCH] mm: balance dirty pages".
> iozone is running with option -B (using mmap) for file size 120% of RAM.
> 

That is expected and intentional.  Previously, `iozone -B' was able to
swamp the whole machine with dirty memory.  That gives good benchmark
numbers, but causes everything else on the machine to be adversely
affected.

The new behaviour will punish iozone for being bad, and will hopefully
cause less damage to other applications.

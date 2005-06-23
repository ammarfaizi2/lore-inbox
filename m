Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVFWXqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVFWXqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVFWXqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:46:11 -0400
Received: from fmr22.intel.com ([143.183.121.14]:2495 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262904AbVFWXoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:44:23 -0400
Date: Thu, 23 Jun 2005 16:43:51 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [ia64][patch] Refuse inserting kprobe on slot 1
Message-ID: <20050623164351.A26121@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <200506230232.j5N2WgwS018522@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506230232.j5N2WgwS018522@linux.jf.intel.com>; from rusty.lynch@intel.com on Wed, Jun 22, 2005 at 07:32:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 07:32:42PM -0700, Rusty Lynch wrote:
> 
>    +
>    +       if (slot == 1) {
Rusty, this is wrong. You should fail only
	if (slot == 1) && (bundle_encoding[template][1] != L) {
This is because for MLX template we will actually be patching
the instruction on slot = 2 and not on slot 1.
>    +               printk(KERN_WARNING "Inserting kprobes on slot #1 "
>    +                      "is not supported\n");
>    +               return -EINVAL;
>    +       }
>    +
>            return 0;
>     }
> 

-Anil

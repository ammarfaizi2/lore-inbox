Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752145AbWCCEGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbWCCEGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWCCEGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:06:43 -0500
Received: from ozlabs.org ([203.10.76.45]:58282 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752145AbWCCEGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:06:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17415.49336.31224.641069@cargo.ozlabs.ibm.com>
Date: Fri, 3 Mar 2006 15:06:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, akpm@osdl.org
Subject: Re: jiffies_64 vs. jiffies
In-Reply-To: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto writes:

> Hi.  I noticed that the 'jiffies' variable has 'wall_jiffies + 1'
> value in most of time.  I'm using MIPS platform but I think this is
> same for other platforms.
> 
> I suppose this is due to gcc does not know that jiffies_64 and jiffies
> share same place.

I can confirm that the same thing happens on powerpc, both 32-bit and
64-bit.  The compiler loads up jiffies, jiffies_64 and wall_jiffies
into registers before storing back the incremented value into
jiffies_64 and then updating wall_jiffies.

Thanks for finding that, it explains some other strange things that I
have seen happen.

Paul.

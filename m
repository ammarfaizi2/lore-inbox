Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268245AbTCFTYK>; Thu, 6 Mar 2003 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTCFTYK>; Thu, 6 Mar 2003 14:24:10 -0500
Received: from ltgp.iram.es ([150.214.224.138]:43649 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S268245AbTCFTYJ>;
	Thu, 6 Mar 2003 14:24:09 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 6 Mar 2003 20:33:44 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, randy.dunlap@verizon.net,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] move SWAP option in menu
Message-ID: <20030306193344.GA29166@iram.es>
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es> <20030305131444.1b9b0cf2.rddunlap@osdl.org> <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 11:43:32AM -0700, Tom Rini wrote:
> 
> How's this look?  I picked MMU=x implies SWAP=x for defaults, just
> because that's how they were before...

I'd be very surprised if it were possible to have swap on a MMU-less 
machine (no virtual memory, page faults, etc.). Except for this nitpick, 
the patch looks fine, but my knowledge of MM is close to zero (and 
also of the new config language, but I'll have to learn it soon).

> ===== init/Kconfig 1.10 vs edited =====
> --- 1.10/init/Kconfig	Mon Feb  3 13:19:37 2003
> +++ edited/init/Kconfig	Thu Mar  6 11:41:51 2003
> @@ -37,6 +37,16 @@
>  
>  menu "General setup"
>  
> +config SWAP
> +	bool "Support for paging of anonymous memory"
> +	default y if MMU
> +	default n if !MMU

Should rather be (from just reading kconfig-language.txt):

config SWAP
	depends on MMU
	bool "Support for paging of anonymous memory"
	default y

Comments?

	Gabriel.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWDUAKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWDUAKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWDUAK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:10:29 -0400
Received: from mga06.intel.com ([134.134.136.21]:46730 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932151AbWDUAK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:10:28 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25821005:sNHT52349388"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25820990:sNHT64419614"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25839704:sNHT39516302"
Date: Thu, 20 Apr 2006 17:07:55 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org, anil.s.keshavamurthy@intel.com
Cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 6/7] Kprobes registers for notify page fault
Message-ID: <20060420170754.A12384@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com> <20060420233912.410449785@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060420233912.410449785@csdlinux-2.jf.intel.com>; from anil.s.keshavamurthy@intel.com on Thu, Apr 20, 2006 at 04:25:02PM -0700
X-OriginalArrivalTime: 21 Apr 2006 00:10:25.0653 (UTC) FILETIME=[FD44D250:01C664D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:25:02PM -0700, Anil S Keshavamurthy wrote:
> ---

Ha..I had missed the description again.


Patch Description:
Kprobes now registers for page fault notifications.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavmurthy@intel.com>

>  kernel/kprobes.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
> +++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
> @@ -544,6 +544,11 @@ static struct notifier_block kprobe_exce
>  	.priority = 0x7fffffff /* we need to notified first */
>  };
>  
> +static struct notifier_block kprobe_page_fault_nb = {
> +	.notifier_call = kprobe_exceptions_notify,
> +	.priority = 0x7fffffff /* we need to notified first */
> +};
> +
>  int __kprobes register_jprobe(struct jprobe *jp)
>  {
>  	/* Todo: Verify probepoint is a function entry point */
> @@ -654,6 +659,9 @@ static int __init init_kprobes(void)
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
>  
> +	if (!err)
> +		err = register_page_fault_notifier(&kprobe_page_fault_nb);
> +
>  	return err;
>  }
>  
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

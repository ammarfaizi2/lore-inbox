Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbSLKLJ2>; Wed, 11 Dec 2002 06:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbSLKLJ2>; Wed, 11 Dec 2002 06:09:28 -0500
Received: from holomorphy.com ([66.224.33.161]:4513 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267110AbSLKLJ1>;
	Wed, 11 Dec 2002 06:09:27 -0500
Date: Wed, 11 Dec 2002 03:16:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, ak@suse.de, cminyard@mvista.com,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021211111639.GJ9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Vamsi Krishna S ." <vamsi@in.ibm.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Kernel List <linux-kernel@vger.kernel.org>,
	lkcd-devel@lists.sourceforge.net, ak@suse.de, cminyard@mvista.com,
	vamsi_krishna@in.ibm.com
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211165153.A17546@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 04:51:53PM +0530, Vamsi Krishna S . wrote:
> I support this, it makes all kernel-space debug tools less intrusive. 
> It may be out of scope for this work but there are a couple of
> other issues to consider here:
> - turn trap1/trap3 to interrupt gates: kprobes does this, kgdb turns
>   off interrupts in its own handler, I suppose other tools too need
>   this.
> - notifier lists are racy on SMP, IFAICT, read_lock(&notifier_lock)
>   needs to be taken in notifier_call_chain(), but that too is 
>   deadlock prone.
> Andi,
> Isn't this a problem on x86_64 too? What is there to prevent a
> handler from being removed from the notifier list while it
> is being used to call the handler on another CPU?
> I am considering using a RCU-based list for notifier chains.
> Corey has done some work on these lines to add NMI notifier
> chain, I think it should be generalised on for all notifiers.

A coherent explanation of how notifier locking is supposed to work
would be wonderful to have. I'd like to register notifiers but am
pig ignorant of how to lock my structures down to work with it.

Bill

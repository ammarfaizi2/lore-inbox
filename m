Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVEWRp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVEWRp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEWRnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:43:42 -0400
Received: from fmr24.intel.com ([143.183.121.16]:54746 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261887AbVEWRlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:41:42 -0400
Date: Mon, 23 May 2005 10:40:46 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustycorp.com.au, vatsa@in.ibm.com
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050523104046.B8692@unix-os.sc.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050523171212.GF39821@muc.de>; from ak@muc.de on Mon, May 23, 2005 at 07:12:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 07:12:12PM +0200, Andi Kleen wrote:
> > The only other workable alternate would be to use the stop_machine() 
> > like thing which we use to automically update cpu_online_map. This means we 
> > execute a high priority thread on all cpus, bringing the system to knees before
> 
> That is not nice agreed.
> 
> > just adding a new cpu. On very large systems this will definitly be 
> > visible.
> 
> I still dont quite get it why it is not enough to keep interrupts
> off until the CPU enters idle. Currently we enable them shortly
> in the middle of the initialization (whcih is already dangerous
> because interrupts can see half initialized state like out of date TSC),
> but I hope to get rid of that soon too. With the full startup
> in CLI would you problems be gone?
> 

I think so, if we can ensure none is delivered to the partially up cpu
we probably are covered.

Iam not a 100% sure about above either, if the smp_call_function 
is started with 3 cpus initially, and 1 just came up, the counts in 
the smp_call data struct could be set to 3 as a result of the new cpu 
received this broadcast as well, and we might quit earlier in the wait.

sending to only relevant cpus removes that ambiquity. 

[Vatsa would know this better, since was the corner case man then :-)]

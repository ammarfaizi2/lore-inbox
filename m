Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWGEVRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWGEVRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWGEVRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:17:08 -0400
Received: from mga05.intel.com ([192.55.52.89]:11525 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S965031AbWGEVRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:17:07 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="93656598:sNHT29346219"
Date: Wed, 5 Jul 2006 14:09:48 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060705140948.B7271@unix-os.sc.intel.com>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <20060703052538.GB13415@elte.hu> <20060702224247.21e8aa8f.akpm@osdl.org> <20060703060320.GA15782@elte.hu> <20060703060832.GA15940@elte.hu> <20060705123629.A7271@unix-os.sc.intel.com> <20060705200245.GB13070@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060705200245.GB13070@elte.hu>; from mingo@elte.hu on Wed, Jul 05, 2006 at 10:02:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 10:02:45PM +0200, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > -		if (sd && sd->flags & flag)
> > +		if (sd && !(sd->flags & flag))
> 
> use test_sd_flag() here, as i did in my fix patch.
> 
> > -#define test_sd_flag(sd, flag)	((sd && sd->flags & flag) ? 1 : 0)
> > +#define test_sd_flag(sd, flag)	((sd && (sd->flags & flag)) ? 1 : 0)
> 
> remove the 'sd' check in test_sd_flag. In the other cases we know that 
> there's an sd. (it's usually a sign of spaghetti code if tests like this 
> include a check for the existence of the object checked)

In other cases, we are passing sd->parent as the first argument to
test_sd_flag(). We know that there is a 'sd' but not sure about sd->parent or
sd->child.

thanks,
suresh

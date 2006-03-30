Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWC3ANB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWC3ANB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWC3ANB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:13:01 -0500
Received: from mga07.intel.com ([143.182.124.22]:4913 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751281AbWC3ANA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:13:00 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,145,1141632000"; 
   d="scan'208"; a="16569140:sNHT50229277"
Date: Wed, 29 Mar 2006 16:12:59 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060329161258.A13186@unix-os.sc.intel.com>
References: <20060329220808.GA1716@elf.ucw.cz> <200603300936.22757.ncunningham@cyclades.com> <20060329154748.A12897@unix-os.sc.intel.com> <200603300953.32298.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200603300953.32298.ncunningham@cyclades.com>; from ncunningham@cyclades.com on Thu, Mar 30, 2006 at 09:53:26AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:53:26AM +1000, Nigel Cunningham wrote:
> 
> >  config SUSPEND_SMP
> >         bool
> > -       depends on HOTPLUG_CPU && X86 && PM
> > +       depends on HOTPLUG_CPU && X86 && PM && X86_GENERICARCH
> >         default y
> 
> Sounds like the right approach to me, but I think it's better to use selects. 
> I reckon that if the user selects SMP and then selects suspend support, 
> everything else required should be automatic. If we do too many 'depends 
> on's, they have to mess about figuring out what they haven't selected yet and 
> why they can't find the option to suspend. Most people don't seem to know 
> about '/' in make menuconfig.
> 

I tried the same with HOTPLUG_CPU as well, to just say 

select X86_GENERICARCH

but problem was this didnt enforce the selection, i.e user still could go and revert
the selection made automatic for him, i.e go ahead and select X86_PC, and it would 
still leave the HOTPLUG_CPU=y around. I thought "depends" sort of forces the selection.

Maybe i didnt try correctly, if you have alternatives please do, actually even for 
HOTPLUG_CPU if this could be made automatic select, and at the same time enforced
strictly, thats great.

(for e.g i shoud;t be able to select X86_PC=y and leave CONFIG_HOTPLUG_CPU=y around)





-- 
Cheers,
Ashok Raj
- Open Source Technology Center

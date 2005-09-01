Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVIAV1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVIAV1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVIAV1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:27:43 -0400
Received: from fmr23.intel.com ([143.183.121.15]:40423 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030349AbVIAV1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:27:42 -0400
Date: Thu, 1 Sep 2005 14:26:59 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Ashok Raj <ashok.raj@intel.com>, shaohua.li@intel.com,
       zwane@arm.linux.org.uk, akpm@osdl.org, ak@suse.de,
       lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hotplug_sig@lists.osdl.org
Subject: Re: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Message-ID: <20050901142659.A29600@unix-os.sc.intel.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D14@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D14@USRV-EXCH4.na.uis.unisys.com>; from Natalie.Protasevich@UNISYS.com on Thu, Sep 01, 2005 at 04:09:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:09:09PM -0500, Protasevich, Natalie wrote:
> > 
> > > Current IA32 CPU hotplug code doesn't allow bringing up 
> > processors that were not present in the boot configuration. 
> > > To make existing hot plug facility more practical for physical hot 
> > > plug, possible processors should be encountered during boot for 
> > > potentual hot add/replace/remove. On ES7000, ACPI marks all the 
> > > sockets that are empty or not assigned to the partitionas as 
> > > "disabled". The patch allows arrays/masks with APIC info 
> > for disabled 
> > > processors to be
> > 
> > This sounds like a cluge to me. The correct implementation 
> > would be you would need some sysmgmt deamon or something that 
> > works with the kernel to notify of new cpus and populate 
> > apicid and grow cpu_present_map. Making an assumption that 
> > disabled APICID are valid for ES7000 sake is not a safe assumption.
> 
> Yes, this is a kludge, I realize that. The AML code was not there so far
> (it will be in the next one). I have a point here though that if the
> processor is there, but is unusable (what "disabled" means as the ACPI
> spec says), meaning bad maybe, then with physical hot plug it can
> certainly be made usable and I think it should be taken into
> consideration (and into configuration). It should be counted as possible
> at least, with hot plug, because it represent existing socket. 


I think marking it as present, and considering in cpu_possible_map is perfectly
ok. But we would need more glue logic, that is if firmware marked it as 
disabled, then one would expect you then run _STA and find that the CPU
is now present and functional as reported by _STA, then the CPU is onlinable.

So if _STA can work favorably in your case you can use it to override the 
disabled setting at boot time which would be prefectly fine.
> 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWBQVFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWBQVFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWBQVFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:05:31 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59237 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751797AbWBQVFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:05:31 -0500
Message-ID: <43F63A59.6090401@cfl.rr.com>
Date: Fri, 17 Feb 2006 16:04:25 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 21:06:53.0045 (UTC) FILETIME=[13A1B250:01C63406]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14274.000
X-TM-AS-Result: No--9.990000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> Yes, it's a very good model, in fact what I've been talking about.
> However, several people who refused to read or understand, insisted
> upon obtaining the exact same C/H/S that the machine claimed to
> use when it was booted.
> 

That's because if you don't use the same geometry that the bios reports 
when calculating the CHS addresses of the sectors you intend to load, 
you won't be requesting the right sectors from int 13.

> So, since Linux doesn't destroy that information remaining in
> the BIOS tables, I show how to make it available to a 'root' user.
> Observation over several machines will show that the BIOS always
> uses the same stuff for large media and, in fact, it has no choice.
> Basically, this means that the first part of the boot-code, the
> stuff that needs to be translated to fit into the int 0x13 registers,
> needs to be below 1024 cylinders, 63 sectors-track, and 256 heads.
> Trivial... even LILO was able to do that! Once the machine boots
> past the requirement to use the BIOS services, it's a CHS=NOP.
> 

Generally yes, modern large disks will get clamped at 1024 cylinders, 
255 heads, and 63 sectors.  You seem to be arguing that this will always 
be the case.  If that is so, then the kernel doesn't need to store these 
values since it is known a priori does it?  But it isn't always going to 
be 255/63, there are some bioses ( I forget which ) that cap the number 
of heads at 240, and disks that are smaller than 8 gigs also will have 
less than 255 heads.



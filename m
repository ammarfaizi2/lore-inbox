Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWHYNtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWHYNtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWHYNtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:49:09 -0400
Received: from mga07.intel.com ([143.182.124.22]:56851 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932225AbWHYNtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:49:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,168,1154934000"; 
   d="scan'208"; a="107511327:sNHT51938740"
Message-ID: <44EEFFC8.40202@linux.intel.com>
Date: Fri, 25 Aug 2006 15:48:56 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Kiszka <jan.kiszka@googlemail.com>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, dwalker@mvista.com,
       nickpiggin@yahoo.com.au, rpm@xenomai.org
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
References: <1156504939.3032.26.camel@laptopd505.fenrus.org> <58d0dbf10608250643v1bb19d0ci99ae30243125a962@mail.gmail.com>
In-Reply-To: <58d0dbf10608250643v1bb19d0ci99ae30243125a962@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka wrote:
>> The patch below adds infrastructure to track "maximum allowable 
>> latency" for
>> power saving policies.
> 
> Very interesting approach. I wonder if it could be used to cover
> another problematic source of latencies as well: asynchronous SMIs.
> They quickly cause delays reaching from a few 100 us up to
> milliseconds.
> 
> Hard-RT extension like Xenomai work around this on several Intel
> chipsets by disabling SMI unconditionally 


I would consider that a mistake. SMI's are used to do things like emergency thermal protections etc etc.
Disabling them unconditionally is going to risk you your hardware.

> I guess an interface to let also applications / the sysadmin specifiy
> a latency constraint would be useful as well. sysfs?

I thought about this a lot but decided against. There are already ways to do things like disable specific C states etc,
and if we expose this it'll mostly get abused by certain desktop applications who have no idea what they are doing ;=(
What makes anyone think that userspace could make a better decision than the drivers?
Video / Audio playback are not good examples since these both already would work automatically correct with only in-kernel
infrastructure. Hard-RT systems are also not a good example since those should use the existing boot parameters. I couldn't
come up with other scenarios, and until we have a good one I'm against exposing crap to sysfs "just because we can".

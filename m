Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVARNMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVARNMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVARNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:12:40 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:20496 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261270AbVARNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:12:37 -0500
Message-ID: <41ED0D3A.1070902@hist.no>
Date: Tue, 18 Jan 2005 14:20:58 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rddunlap@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, dsd@gentoo.org,
       jhf@rivenstone.net, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       opengeometry@yahoo.ca
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
References: <20050114002352.5a038710.akpm@osdl.org>	<20050116005930.GA2273@zion.rivenstone.net>	<41EC7A60.9090707@gentoo.org>	<20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>	<41EC5207.3030003@osdl.org>	<41ECC8AF.9020404@hist.no> <20050118004935.7bd4a099.akpm@osdl.org>
In-Reply-To: <20050118004935.7bd4a099.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Helge Hafting <helge.hafting@hist.no> wrote:
>  
>
>>The USB block driver should know that 10s (or whatever) hasn't yet 
>> passed, and simply
>> block any attempt to access block devices (or scan for them) knowing 
>> that it will
>> not work yet, but any device will be there after the pause. A root mount 
>> on USB will
>> then succeed at the _first_ try everytime, so no need for retries.
>>    
>>
>
>Maybe a simple delay somewhere in the boot sequence would suffice?  Boot
>with `mount_delay=10'.
>
>  
>
Certainly the simplest solution, and it also solves a related
but rare problem: People booting linux from ROM long before
the disks have time to spin up.

There seems to be a disadvantage in that one must specify
this pause manually, but the admin have to select the root fs
somewhere anyway (lilo.conf) and may specify the delay at
the same time.

>But it sure would be nice to simply get this stuff right somehow.  If the
>USB block driver knows that discovery is still in progress it should wait
>until it has completed.  (I suggested that before, but wasn't 100% convinced
>by the answer).
>  
>
Sure, if the USB core can know, then it should use the knowledge.
Or utilize a simple timeout if all it knows is that "common
storage devices appear on the bus up to 10s after powerup/reset".

Helge Hafting

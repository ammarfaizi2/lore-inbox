Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVFUIWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVFUIWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVFUIU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:20:59 -0400
Received: from cpc4-cmbg4-4-0-cust124.cmbg.cable.ntl.com ([81.108.205.124]:15371
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S261983AbVFUHrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:47:24 -0400
Message-ID: <42B7C4D0.9070809@thekelleys.org.uk>
Date: Tue, 21 Jun 2005 08:42:08 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jirka Bohac <jbohac@suse.cz>
CC: Denis Vlasenko <vda@ilport.com.ua>, Pavel Machek <pavel@ucw.cz>,
       Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100: firmware problem
References: <20050608142310.GA2339@elf.ucw.cz> <200506081744.20687.vda@ilport.com.ua> <20050608145653.GA8844@dwarf.suse.cz>
In-Reply-To: <20050608145653.GA8844@dwarf.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jirka Bohac wrote:
> On Wed, Jun 08, 2005 at 05:44:20PM +0300, Denis Vlasenko wrote:
> 
>>On Wednesday 08 June 2005 17:23, Pavel Machek wrote:
>>
>>>What's the prefered way to solve this one? Only load firmware when
>>>user does ifconfig eth1 up? [It is wifi, it looks like it would be
>>>better to start firmware sooner so that it can associate to the
>>>AP...].
>>
>>Do you want to associate to an AP when your kernel boots,
>>_before_ any iwconfig had a chance to configure anything?
>>That's strange.
>>
>>My position is that wifi drivers must start up in an "OFF" mode.
>>Do not send anything. Do not join APs or start IBSS.
> 
> 
> Agreed.
> 
> 
>>Thus, no need to load fw in early boot.
> 
> 
> I don't think this is true. Loading the firmware on the first
> "ifconfig up" is problematic. Often, people want to rename the
> device from ethX/wlanX/... to something stable. This is usually
> based on the adapter's MAC address, which is not visible until
> the firmware is loaded.
> 
> Prism54 does it this way and it really sucks. You need to bring
> the adapter up to load the firmware, then bring it back down,
> rename it, and bring it up again.
> 

The atmel driver includes a small firmware stub which does nothing but 
determine the MAC address, to solve this problem. This is compiled into 
the driver and so doesn't depend on request_firmware(). The stub was 
created by reverse engineering the card and is GPL, so there's no 
problem including it in the kernel.

This is not a general solution, since it depends on the ability to 
create such MAC reader firmware, but it might be a possibility in this case.


Cheers,

Simon.

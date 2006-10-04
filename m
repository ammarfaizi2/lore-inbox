Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWJDFvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWJDFvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJDFvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:51:18 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:673 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161087AbWJDFvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:51:17 -0400
Message-ID: <45234ABF.5030107@jp.fujitsu.com>
Date: Wed, 04 Oct 2006 14:46:39 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>, Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org,
       MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
       Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, davem@davemloft.net
Subject: Re: The change "PCI: assign ioapic resource at hotplug" breaks my
 system
References: <adar6xqwsuw.fsf@cisco.com>	<45225876.1080705@jp.fujitsu.com> <20061003110217.5ea3e152@dxpl.pdx.osdl.net>
In-Reply-To: <20061003110217.5ea3e152@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen, Roland,

Thank you very much for testing the patch.

Thanks,
Kenji Kaneshige


Stephen Hemminger wrote:
> On Tue, 03 Oct 2006 21:32:54 +0900
> Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> 
>> Roland Dreier wrote:
>>> The change "PCI: assign ioapic resource at hotplug" (commit
>>> 23186279658cea6d42a050400d3e79c56cb459b4 in Linus's tree) makes
>>> networking stop working on my system (SuperMicro H8QC8 with four
>>> dual-core Opteron 885 CPUs).  In particular, the on-board NIC stops
>>> working, probably because it gets assigned the wrong IRQ (225 in the
>>> non-working case, 217 in the working case)
>>>
>>> With that patch applied, e1000 doesn't work.  Reverting just that
>>> patch (shown below) from Linus's latest tree fixes things for me.
>>>
>>> Please let me know what other debug information might be useful.
>>>
>> The cause of this problem might be an wrong assumption that the 'start'
>> member of resource structure for ioapic device has non-zero value if the
>> resources are assigned by firmware. The 'start' member of ioapic device
>> seems not to be set even though the resources were actually assigned to
>> ioapic devices by firmware.
>>
>> I made a patch to fix this problem against 2.6.18-git18. This patch
>> checks command register instead of checking 'start' member to see if
>> the ioapic is already enabled by firmware. Unfortunately, I don't have
>> any system to reproduce this problem. Could you please try it and let
>> me know whether the problem is fixed? If the patch below fixes the
>> problem, I'll resend it with description and Signed-off-by.
>>
>> Thanks,
>> Kenji Kaneshige
>>
> 
> This also fixes my problems with the built in tg3 on the dual CPU Opteron
> IBM workstation.
> 
> 



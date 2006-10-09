Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWJIRei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWJIRei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWJIRei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:34:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44695 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964771AbWJIReh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:34:37 -0400
Message-ID: <452A881E.40706@pobox.com>
Date: Mon, 09 Oct 2006 13:34:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, sukadev@us.ibm.com
Subject: Re: Panic in pci_call_probe from 2.6.18-mm2 and 2.6.18-mm3
References: <4528A26F.9000804@mbligh.org> <1160414389.17103.7.camel@dyn9047017100.beaverton.ibm.com> <452A85D8.70806@mbligh.org>
In-Reply-To: <452A85D8.70806@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Badari Pulavarty wrote:
>> On Sun, 2006-10-08 at 00:02 -0700, Martin J. Bligh wrote:
>>
>>> Not sure if you've seen this already ... catching up on test results.
>>>
>>> This was on NUMA-Q, on both -mm2 and -mm3. -mm1 didn't suffer from this
>>> problem.
>>>
>>> Full logs:
>>>
>>> mm2 - http://test.kernel.org/abat/50727/debug/console.log
>>> mm3 - http://test.kernel.org/abat/51442/debug/console.log
>>>
>>> config - http://test.kernel.org/abat/51442/build/dotconfig
>>>
>>> I'm guessing from the 00000004 that the pcibus_to_node(dev->bus)
>>> is failing because bus->sysdata is NULL. The disassembly and
>>> structure offsets seem to line up for that.
>>>
>>> #define pcibus_to_node(bus) (
>>>     (struct pci_sysdata *)((bus)->sysdata))->node
>>>
>>> struct pci_sysdata {
>>>         int             domain;         /* PCI domain */
>>>         int             node;           /* NUMA node */
>>> };
>>>
>>
>>
>> Martin,
>>
>> Jeff moved "node" to a proper field in sysdata, instead
>> of overloading sysdata itself. I think this is causing the
>> problem. I guess we could end up with sysdata = NULL in some
>> cases ? Since you are the NUMA-Q expert, where does sysdata gets set 
>> for NUMA-Q ? :)
>>
>> -mm2 changed:
>>
>> #define pcibus_to_node(bus) ((long) (bus)->sysdata)
>>
>> to
>> #define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))-
>>
>>> node
> 
> Buggered if I know, that's some strange pci thing ;-)
> 
> But can we revert whatever patch that was until it gets fixed, please?

It needs to get fixed, otherwise whose buses of PCI devices disappear on 
some machines.

Can you turn on PCI debugging?

	Jeff




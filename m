Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWJIRYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWJIRYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbWJIRYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:24:43 -0400
Received: from dvhart.com ([64.146.134.43]:43914 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964775AbWJIRYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:24:42 -0400
Message-ID: <452A85D8.70806@mbligh.org>
Date: Mon, 09 Oct 2006 10:24:40 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: jgarzik@pobox.com, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, sukadev@us.ibm.com
Subject: Re: Panic in pci_call_probe from 2.6.18-mm2 and 2.6.18-mm3
References: <4528A26F.9000804@mbligh.org> <1160414389.17103.7.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1160414389.17103.7.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Sun, 2006-10-08 at 00:02 -0700, Martin J. Bligh wrote:
> 
>>Not sure if you've seen this already ... catching up on test results.
>>
>>This was on NUMA-Q, on both -mm2 and -mm3. -mm1 didn't suffer from this
>>problem.
>>
>>Full logs:
>>
>>mm2 - http://test.kernel.org/abat/50727/debug/console.log
>>mm3 - http://test.kernel.org/abat/51442/debug/console.log
>>
>>config - http://test.kernel.org/abat/51442/build/dotconfig
>>
>>I'm guessing from the 00000004 that the pcibus_to_node(dev->bus)
>>is failing because bus->sysdata is NULL. The disassembly and
>>structure offsets seem to line up for that.
>>
>>#define pcibus_to_node(bus) (
>>	(struct pci_sysdata *)((bus)->sysdata))->node
>>
>>struct pci_sysdata {
>>         int             domain;         /* PCI domain */
>>         int             node;           /* NUMA node */
>>};
>>
> 
> 
> Martin,
> 
> Jeff moved "node" to a proper field in sysdata, instead
> of overloading sysdata itself. I think this is causing the
> problem. I guess we could end up with sysdata = NULL in some
> cases ? Since you are the NUMA-Q expert, where does sysdata 
> gets set for NUMA-Q ? :)
> 
> -mm2 changed:
> 
> #define pcibus_to_node(bus) ((long) (bus)->sysdata)
> 
> to 
> 
> #define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))-
> 
>>node

Buggered if I know, that's some strange pci thing ;-)

But can we revert whatever patch that was until it gets fixed, please?

Thanks,

M.

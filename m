Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVFMWrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVFMWrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVFMWqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:46:06 -0400
Received: from amdext4.amd.com ([163.181.251.6]:42628 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S261618AbVFMWpP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:45:15 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] [OOPS] powernow on smp dual core amd64
Date: Mon, 13 Jun 2005 17:44:55 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84301CFC14D@SAUSEXMB1.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [OOPS] powernow on smp dual core amd64
Thread-Index: AcVwZiv7cvc79z8nRxuodjK7cDSeHAAASfCQ
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Tom Duffy" <tduffy@sun.com>
cc: discuss@x86-64.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-WSS-ID: 6EB0D3E22DO7608542-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2005-06-13 at 16:47 -0500, Langsdorf, Mark wrote:
> > Okay, I think I have figured this out.  During initialization, the 
> > cpufreq infrastruture only initializes the first core of each 
> > processor.  When a request comes into the second core, it's data 
> > structre is unitialized and we get the null point dereference.
> > 
> > The solution is to assign the pointer to the data structure for the 
> > first core to all the other cores.
> > 
> > Tom, could you try this patch and see if it helps?
> 
> Yes!  It fixed the panic.  I get much further.

Great, I'll test that some more then submit it.

> Unfortunately, after starting cpuspeed daemon, I get this:

It looks like it's happening sometime after cpuspeed starts.
Could you disable cpuspeed and see if the problem still
occurs? 

> Starting cpuspeed: [  OK  ]
> Starting pcmcia:  Starting PCMCIA services:
> CPU 6: Machine Check Exception:                4 Bank 4: 
> b200000000070f0f
> TSC 4129a3d70d

> Code:  Bad RIP value.
> RIP [<00000000000000ff>] RSP <ffff81003fe63fa0>
> CR2: 00000000000000ff
>  <0>Kernel panic - not syncing: Oops

Andi said that "Something tried to access a physical memory 
address that was not mapped in the CPU."  Andi, is this
related to the bug that you thought might have been fixed
in 2.6.12-rc6-git4?

-Mark Langsdorf
AMD, Inc.


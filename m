Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTLDAS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTLDAS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:18:29 -0500
Received: from stinkfoot.org ([65.75.25.34]:20352 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S262355AbTLDAS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:18:27 -0500
Message-ID: <3FCE7D3B.5040206@stinkfoot.org>
Date: Wed, 03 Dec 2003 19:18:03 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: HT apparently not detected properly on 2.4.23
References: <3FCE2F8E.90104@stinkfoot.org> <20031203224023.GV8039@holomorphy.com> <3FCE74B0.9010506@stinkfoot.org> <20031203235837.GW8039@holomorphy.com>
In-Reply-To: <20031203235837.GW8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Wed, Dec 03, 2003 at 06:41:36PM -0500, Ethan Weinstein wrote:
> 
>>But we're still only interrupting on CPU0 with this kernel.
> 
> 
> That's P-IV retardation. Not really fixable, but irqbalance daemons
> etc. can help mitigate the severity of the erratum. I'm not sure if
> 2.4 has the interfaces for the userspace solutions to work or the
> kernel solutions either.
> 

I somehow suspected that, and appreciate the clarification.  I'll see if 
I can't get that patch I found to apply to 2.4.23, it seems to solve 
this a bit more elegantly than the irqbalance program.

            CPU0       CPU1       CPU2       CPU3
   0:      67962      69066      68010      68954    IO-APIC-edge  timer
   1:          1          0          0          1    IO-APIC-edge  keyboard
   2:          0          0          0          0          XT-PIC  cascade
   3:      10027      10944       9904      11063    IO-APIC-edge  serial
   8:          2          0          0          0    IO-APIC-edge  rtc
  16:          9          7          7         18   IO-APIC-level  sym53c8xx
  22:       6842       7336       7166       7429   IO-APIC-level  eth0
  48:       6429       6370       6202       6268   IO-APIC-level  aic79xx
  49:       1939       2018       2067       1949   IO-APIC-level  aic79xx
  54:        340        345        340        352   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:     273824     273846     273844     273845
ERR:          0
MIS:          0

-Ethan



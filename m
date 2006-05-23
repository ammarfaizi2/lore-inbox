Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWEWVcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWEWVcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWEWVcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:32:12 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:23214 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932291AbWEWVcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:32:11 -0400
In-Reply-To: <44737D53.9050006@tektonic.net>
References: <4468BE70.7030802@tektonic.net>	<4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei>	<446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net>	<4470A6CD.5010501@trash.net> <4471CB54.401@tektonic.net>	<4471CE19.5070802@trash.net> <bf76eefc5234d32440c822acd2879a8a@cl.cam.ac.uk> <44737D53.9050006@tektonic.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5e589307bfef58553bfda1d7ab47f9f3@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Patrick McHardy <kaber@trash.net>, James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
Date: Tue, 23 May 2006 22:27:17 +0100
To: Matt Ayres <matta@tektonic.net>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 May 2006, at 22:23, Matt Ayres wrote:

>> Having looked at disassembly, the fault happens when accessing 
>> e->ip.invflags in ip_packet_match() inlined inside ipt_do_table().
>>  e = private->entries[smp_processor_id()] + 
>> private->hook_entry[NF_IP_FORWARD]
>> smp_processor_id() should be 0 (since the oops appears to occur on 
>> cpu0) and presumably all the ipt_entry structures are static once set 
>> up. Since this crash happens on a common path in ipt_do_table(), and 
>> since it happens only after the system has been up a while (I 
>> believe?), it rather looks as though something has either corrupted a 
>> pointer or unmapped memory from under iptables' feet.
>
> As the concerned user, what does this mean to me?  It will only affect 
> SMP systems?  It is a bug in Xen or netfilter?

Probably a Xen bug, but if so then it's basically a memory corruption. 
It's weird it would hit the iptables rules every time though, and not 
be a more random crash. This might well need reproducing in a developer 
test-machine environment to stand a chance of tracking down.

  -- Keir

> I'd just like to understand what is going on.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWEWMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWEWMEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWEWMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 08:04:44 -0400
Received: from mail.unixshell.com ([207.210.106.37]:49567 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S1751187AbWEWMEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 08:04:43 -0400
Message-ID: <4472FA09.1010800@tektonic.net>
Date: Tue, 23 May 2006 08:03:21 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: Patrick McHardy <kaber@trash.net>, James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei> <446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net> <4470A6CD.5010501@trash.net> <4471CB54.401@tektonic.net> <4471CE19.5070802@trash.net> <fb268aac0218b2a558e922858f99b20b@cl.cam.ac.uk>
In-Reply-To: <fb268aac0218b2a558e922858f99b20b@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> 
> On 22 May 2006, at 15:43, Patrick McHardy wrote:
> 
>> The only other thing I can imagine is that something is wrong with
>> the per-CPU copy of the ruleset, i.e. either smp_processor_id is
>> returning garbage or for_each_possible_cpu misses a CPU during
>> initialization. I have no idea if Xen really does touch this code,
>> but other than that I don't really see what it could break.
> 
> Of the options you consider, this sounds most likely. Really we need 
> some more info from a crash: I'd like to get disassembly from a vmlinux 
> image if that's possible, Matt.
> 

I have an un-stripped vmlinux built with kernel debugging and the 
corresponding System.map.  I will be sending these to you privately 
shortly.  You can see the multiple traces sent to this list.

It appears having the bandwidth accounting being performed by count 
rules in the FORWARD chain is causing it for my setup.  I suppose I 
could optimize this to make the kernel spend as little time in 
ipt_do_table in regards to the FORWARD chain.  I flushed the FORWARD 
chain (normally 100-120 rules) and have not experienced any crashes so 
far... disabling bandwidth monitoring is by no means a long term fix.

It might be more generic in the symptoms, perhaps just any chain with 
many rules and lots of traffic or It's just the FORWARD one that seems 
to be doing it for me as that is where ipt_do_table spends most of it's 
time.

Thanks,
Matt Ayres

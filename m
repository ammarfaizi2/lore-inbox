Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWAXNJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWAXNJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 08:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWAXNJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 08:09:49 -0500
Received: from ns.amrita.ac.in ([203.197.150.194]:37327 "EHLO
	bhadra.amrita.ac.in") by vger.kernel.org with ESMTP
	id S1030470AbWAXNJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 08:09:48 -0500
X-Antivirus-AMRITA-Mail-From: harish@arl.amrita.edu via bhadra.amrita.ac.in
X-Antivirus-AMRITA: 1.25-st-qms (Clear:RC:0(203.197.150.195):SA:0(-2.6/3.5):. Processed in 1.259504 secs Process 8285)
Message-ID: <43D62989.3070108@arl.amrita.edu>
Date: Tue, 24 Jan 2006 18:50:09 +0530
From: Harish K Harshan <harish@arl.amrita.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA Transfer problem
References: <43D5B473.3060006@arl.amrita.edu> <43D624B4.5070300@superbug.co.uk>
In-Reply-To: <43D624B4.5070300@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank You, James,

   But the problem with sound card drivers are that they dont have a 
configurable clock on them, do they??? and as far as i know, this ADC 
card involves a lot of register writings for the counter ICs that help 
configuring the clock speed for the DMA transfer.... First we set the 
control properties, which involves the IRQ, start channel, stop channel, 
etc (the card is an 8-channel ADC), (the jumper settings configure the 
DMA channels that should be used, 1 or 3). Now we initialize the DMA 
controller, so that it throws an interrupt once the transfer of 
DMA_COUNT samples of data. The interrupt service routine for this 
interrupt can handle the data transfer to the user program. Roughly 
thats how the driver works... Now, the problem is that, when running on 
the Chino-Laxsons board PCs, the DMA transfers take varying time to 
complete (say, if one transfer takes one second, the next might take one 
and a half), but this is not supposed to (and doesnt) happen on any 
other machines we tested on. Its absolutely synchronous with the clock, 
and theres the minimal drift. Can anyone suggest why this could be 
happening on this particular board??? And another interesting thing is 
that, this card seems to work fine with the Windows driver available to 
it (provided by the company.). I need help on this very urgently. If 
anybody has had any such experience, and solved it, please let me know.

Thanks in advance,
Harish.

James Courtier-Dutton wrote:

> Harish K Harshan wrote:
>
>> Hello,
>>
>>   Im having problems with DMA transfer on Linux, for an ADC card. The 
>> card is AxiomTek AX5621H, and can use DMA channels 1 and 3. I tried 
>> both the channels, but the DMA transfers are irregular (i.e.) at 
>> different speeds (which of course is not acceptable, since that 
>> application is time critical). The device driver (which I wrote) 
>> seems to work fine for all the other systems I tried it on. But this 
>> problem occurs only on one particular model of computer 
>> (Chino-Laxsons Pentium-4 boards). I tried another system with the 
>> same configuration, but the same resulted. After some time of 
>> execution, I get the kernel panic screen, which says the CPU context 
>> is corrupt. Please help me with this problem, as I need to get this 
>> driver working somehow on the P4 systems. I tried the Redhat-9 kernel 
>> (2.4.20-8) and the debian kernel too (2.2.20).... gave the same results.
>>
> Could an ADC card be treated as a ALSA sound card PCM device.
> That card seems to have features very similar to a sound card.
> Sample rate.
> Variable gain.
> Multi-channels.
> ADC
> DMA
>
> I only suggest this, because it could result in a driver that is much 
> easier to implement as ALSA supplies a lot of generalised support code 
> at the kernel level.
>
> James
>

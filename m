Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWAQOWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWAQOWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWAQOWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:22:42 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:29634 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932506AbWAQOWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:22:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=pE1yVBd/q9kovyEObow6qSTCYRRQfyT1NNYOCDtTn8YPOMJLKanWIfC+2B/+jrC83YCe+OeTWe1c0wrZJMe1emYZTx0nTnxfYCOtb5tY0E51lz8npZhDKS4uJfpHzVKCmLMlijh9jMUMkHlnB98OcFaAisDCoXAzQduBMiP3Pfk=
Message-ID: <43CCFDAA.4010801@gmail.com>
Date: Tue, 17 Jan 2006 15:22:34 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc1 bug] alsa suspend/resume continues to fail for ens1370
References: <43CCF2A4.6020704@gmail.com> <s5hy81f9bln.wl%tiwai@suse.de>
In-Reply-To: <s5hy81f9bln.wl%tiwai@suse.de>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai ha scritto:
> At Tue, 17 Jan 2006 14:35:32 +0100,
> Patrizio Bassi wrote:
>   
>> upgrading from 2.6.15-git5 to 2.6.16-rc1
>>
>> anche compiling my ens1370 driver statically in kernel i still have
>> issues on saving/resuming
>> mixer volumes.
>>
>> even applying this patch (inclused in lastest alsa-cvs snapshot)
>>
>>
>> --- a/sound/pci/ens1370.c       7 Dec 2005 11:13:55 -0000       1.91
>> +++ b/sound/pci/ens1370.c       10 Jan 2006 16:41:08 -0000
>> @@ -2061,6 +2061,13 @@
>>  #ifdef CHIP1371
>>         snd_ac97_suspend(ensoniq->u.es1371.ac97);
>>  #else
>> +       /* try to reset AK4531 */
>> +       outw(ES_1370_CODEC_WRITE(AK4531_RESET, 0x02), ES_REG(ensoniq,
>> 1370_CODEC));
>> +       inw(ES_REG(ensoniq, 1370_CODEC));
>> +       udelay(100);
>> +       outw(ES_1370_CODEC_WRITE(AK4531_RESET, 0x03), ES_REG(ensoniq,
>> 1370_CODEC));
>> +       inw(ES_REG(ensoniq, 1370_CODEC));
>> +       udelay(100);
>>         snd_ak4531_suspend(ensoniq->u.es1370.ak4531);
>>  #endif
>>         pci_set_power_state(pci, PCI_D3hot);
>>
>>
>>
>> it fails with 0x660 errors.
>> i attach my dmesg.
>>
>> Ready to test, as usual :)
>>     
>
> Hm, and does this happen also when you build as modules?
> Does the driver work again if you reload the module after resume?
>
>
> Takashi
>
>   
as module it works without reloading needed, but on suspend i still see
0x660 errors.

the problem is with built-in actually.

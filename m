Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVKCRHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVKCRHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVKCRHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:07:18 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:64385 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030388AbVKCRHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:07:15 -0500
Message-ID: <436A4059.5030804@linuxtv.org>
Date: Thu, 03 Nov 2005 20:52:41 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Manu Abraham <manu@linuxtv.org>, mkrufky@m1k.net,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 01/37] dvb: dst: Correcty Identify Tuner and Daughterboards
References: <4367235B.40608@m1k.net>	<20051103132412.6266ccf0.akpm@osdl.org>	<4369D6B3.60501@linuxtv.org> <20051104012415.1ec337f3.akpm@osdl.org>
In-Reply-To: <20051104012415.1ec337f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Manu Abraham <manu@linuxtv.org> wrote:
>  
>
>>Andrew Morton wrote:
>>
>>    
>>
>>>Michael Krufky <mkrufky@m1k.net> wrote:
>>> 
>>>
>>>      
>>>
>>>>+static int dst_get_tuner_info(struct dst_state *state)
>>>>+{
>>>>+	u8 get_tuner_1[] = { 0x00, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>>>>+	u8 get_tuner_2[] = { 0x00, 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>>>>+
>>>>+	get_tuner_1[7] = dst_check_sum(get_tuner_1, 7);
>>>>+	get_tuner_2[7] = dst_check_sum(get_tuner_2, 7);
>>>>+	if (state->type_flags & DST_TYPE_HAS_MULTI_FE) {
>>>>+		if (dst_command(state, get_tuner_2, 8) < 0) {
>>>>+			dprintk(verbose, DST_INFO, 1, "Unsupported Command");
>>>>+			return -1;
>>>>+		}
>>>>+	} else {
>>>>+		if (dst_command(state, get_tuner_1, 8) < 0) {
>>>>+			dprintk(verbose, DST_INFO, 1, "Unsupported Command");
>>>>+			return -1;
>>>>+		}
>>>>+	}
>>>>+	memset(&state->board_info, '\0', 8);
>>>>+	memcpy(&state->board_info, &state->rxbuffer, 8);
>>>>   
>>>>
>>>>        
>>>>
>>>The memset is unneeded...
>>> 
>>>
>>>      
>>>
>>Hello Andrew,
>>
>>I will have that changed in dvb-kernel CVS. Would you like me to send in 
>>a patch for the same. Or you can have it changed .. ?
>>
>>    
>>
>
>There's certainly no rush ;)  Please just add it to the 2.6.16 to-do list.
>
>  
>

Ok, done. I will queue it up in the TODO list for 2.6.16.


Thanks,
Manu


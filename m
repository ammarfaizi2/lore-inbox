Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVIOLmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVIOLmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVIOLmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:42:25 -0400
Received: from [195.23.16.24] ([195.23.16.24]:9385 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S1751047AbVIOLmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:42:24 -0400
Message-ID: <43295E0B.5000000@grupopie.com>
Date: Thu, 15 Sep 2005 12:42:03 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Roland Dreier <rolandd@cisco.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move GFP_KERNEL use out of line to shrink text
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode> <20050913223511.141e78c1.akpm@osdl.org> <52fys7ze6x.fsf_-_@cisco.com> <200509150813.24041.vda@ilport.com.ua>
In-Reply-To: <200509150813.24041.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Wednesday 14 September 2005 21:39, Roland Dreier wrote:
> 
>>       text    data     bss     dec     hex filename
>>    24202272 7609162 1998512 33809946 203e61a vmlinux-before
>>    24197561 7609474 1998512 33805547 203d4eb vmlinux-after
>>
>>for a net savings of 4711 bytes of text (at a cost of 312 bytes of
>>data for some reason).  With my usual config, the patched kernel boots
>>and runs fine.
> 
> FYI: "some reason" == KALLSYMS

312 bytes for a couple more symbols is too much to be justified from 
kallsyms alone.

In a 64 bit machine each new symbol should take about 8 bytes for the 
address + ~ half the size of the symbol name, which in this case would 
give at most about ~50 bytes.

I guess the rest should come from the extra EXPORT_SYMBOL's...

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain

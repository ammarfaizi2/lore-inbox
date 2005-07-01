Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVGAWS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVGAWS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVGAWS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:18:57 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:31492 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261609AbVGAWSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:18:54 -0400
Message-ID: <42C5C14B.30302@rainbow-software.org>
Date: Sat, 02 Jul 2005 00:18:51 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting uncompressed kernel image on i386?
References: <42C13BF1.1040904@rainbow-software.org> <42C5BB4E.2040000@rainbow-software.org> <20050701221617.GA16873@animx.eu.org>
In-Reply-To: <20050701221617.GA16873@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Ondrej Zary wrote:
> 
>>Nobody answered, time to look at the code :-)
>>The attached patch is a quick hack so "make" will create uncompressed 
>>kernel that can be booted in regular way.
> 
> 
>>--- linux-2.6.12-printserver/arch/i386/boot/compressed/misc.c	2005-06-17 21:48:29.000000000 +0200
>>+++ linux-2.6.12-pentium/arch/i386/boot/compressed/misc.c	2005-07-01 23:34:55.000000000 +0200
>>@@ -374,7 +374,15 @@
>> 
>> 	makecrc();
>> 	putstr("Uncompressing Linux... ");
> 
> 
> Would it not make sense to remove the above line?  You're not actually
> uncompressing anything.
> 
It would but I kept it there for debugging (to see where it crashed :-)
Anyway, I'd like to add new target "make uImage" (or something like 
that) but that requires more work. Something like this might be 
interesting for embedded systems which want to minimalize boot time.

>>-	gunzip();
>>+	int i;
>>+	for (i = 0; i < input_len / WSIZE; i++) {
>>+		memcpy(window, input_data+i*WSIZE, WSIZE);
>>+		outcnt = WSIZE;
>>+		flush_window();
>>+	}
>>+	memcpy(window, input_data+i*WSIZE, input_len % WSIZE);
>>+	outcnt = input_len % WSIZE;
>>+	flush_window();
>> 	putstr("Ok, booting the kernel.\n");
>> 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
>> 	return high_loaded;
> 
> 


-- 
Ondrej Zary

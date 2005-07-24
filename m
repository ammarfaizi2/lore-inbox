Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVGXUlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVGXUlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVGXUlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 16:41:09 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:36142 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261284AbVGXUlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 16:41:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RyTNhBVeeuFZ1inwBTqU7l8qCPL13fWAP8q3+5bsUUc270hRNO9SkqheMbmfvGXcnF0ThxVA8gvc0EHw8DS/lF8PNOVrjRICBzeYeOAVHR2HNFWGsVIKCdwR2MF/mZ1mOrwwXQptcjm1BtXVNmVy7IoP/vfx7SffhP7yPz96tpY=
Message-ID: <42E3FCD1.40102@gmail.com>
Date: Sun, 24 Jul 2005 16:40:49 -0400
From: Puneet Vyas <vyas.puneet@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ciprian <cipicip@yahoo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
In-Reply-To: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ciprian wrote:

>Hi guys!
>
>I got a question for you. Apparently kernel 2.6 is
>much slower then 2.4 and about 30 times slower then
>the windows one.
>
>I'm not an OS guru, but I ran a little and very simple
>test. The program bellow, as you can see, measures the
>number of cycles performed in 30 seconds.
>
>//----------------- START CODE --------------------
>
>#include <stdio.h>
>#include <time.h>
>
>
>int main()
>{
>time_t initialTime;
>time_t testTime;
>long counter = 0;
>double test = 1;
>
>
>time(&initialTime);
>testTime = initialTime;
>
>printf("Here we go...\n");
>
>while((testTime-initialTime) < 30)
>{
>time(&testTime);
>test /= 10;
>test *= 10;
>test += 10;
>test -= 10;
>
>counter ++;
>
>}
>
>printf("No. of cycles: %ld\n", counter);
>
>return 0;
>}
>
>//---------------- END CODE -------------------
>
>
>In windows were performed about 300 millions cycles,
>while in Linux about 10 millions. This test was run on
>Fedora 4 and Suse 9.2 as Linux machines, and Windows
>XP Pro with VS .Net 2003 on the MS side. My CPU is a
>P4 @3GHz HT 800MHz bus.
>
>I published my little test on several forums and I
>wasn't the only one who got these results. All the
>other users using 2.6 kernel obtained similar results
>regardless of the CPU they had (Intel or AMD). 
>
>Also I downloaded the latest kernel (2.6.12),
>configured it specifically for my machine, disabled
>all the modules I don't need and compiled it. The
>result was a 1.7 MB kernel on which KDE moves faster,
>but the processing speed it's the same - same huge
>speed ratios.
>
>Also, it shouldn't have any importance, but my HDD is
>SATA so the specific modules were required. I don't
>think its SCSI modules have any impact on the
>processing speed, but you know more on the kernel
>architecture then I do.
>
>Now, can anyone explain this and suggest what other
>optimizations I should use? The 2.4 version was a lot
>faster. I thought the newer versions were supposed to
>work faster (or at least just as fast) AND to offer
>extra features.
>
>Any help would appreciate.
>
>Thanks,
>Ciprian
>
>
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

Want to increase the latest kernel "speed" by 5 times ? Use the 
follwoing code instead. :)

// -- Start Code
#include <stdio.h>
#include <time.h>


int main()
{
clock_t initialTime;
clock_t testTime;
long counter = 0;
double test = 1;


initialTime = clock() / CLOCKS_PER_SEC;
testTime = initialTime;

printf("Here we go...\n");

while((testTime-initialTime) < 30)
{
testTime = clock()/CLOCKS_PER_SEC;
test /= 10;
test *= 10;
test += 10;
test -= 10;

counter ++;

}

printf("No. of cycles: %ld\n", counter);

return 0;
}
// ---- End code

so essentially you are timing just the time() function.

HTH,
Puneet

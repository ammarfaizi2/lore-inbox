Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWGKPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWGKPEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWGKPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:04:40 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:21154 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1750970AbWGKPEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:04:39 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.6/1.7):. Processed in 1.633789 secs Process 7846)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Robin Holt" <holt@sgi.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <nickpiggin@yahoo.com.au>,
       "Robert Hancock" <hancockr@shaw.ca>, <chase.venters@clientec.com>,
       <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Tue, 11 Jul 2006 20:38:54 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMEEJMDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMMEJLDCAA.abum@aftek.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am not sure about x86, but on ia64, you would be very hard pressed
for this application to actually run you out of memory.  With the
memset commented out, you would be allocating vmas, etc, but you
would not be actually putting pages behind those virtual addresses.

---------------------------  test1.c  ----------------------------------

#include<stdio.h>
#include<string.h>

main()
{
	char* buff;
	int count;

	count=0;
	while(1)
	{
		printf("\nOOM Test: Counter = %d", count);
		buff = (char*) malloc(1024);
	//	memset(buff,'\0',1024);
		count++;

		if (buff==NULL)
		{
			printf("\nOOM Test: Memory allocation error");
		}
	}
}

---------------------------  test1.c  ----------------------------------

>The funniest part is that with memset commented out_of_memory observed,
contrary to my expectation.
>
>I don't know why. It shouldn't have. I am running the application on an ARM
target.

>Regards,
>Abu.

I fail to understand that why the OS doesn't return NULL as per man pages of
malloc. It insteat results in OOM.

~Abu.


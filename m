Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWGKOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWGKOwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWGKOwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:52:55 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:58271 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1750872AbWGKOwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:52:54 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.6/1.7):. Processed in 4.410849 secs Process 5546)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Robin Holt" <holt@sgi.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <nickpiggin@yahoo.com.au>,
       "Robert Hancock" <hancockr@shaw.ca>, <chase.venters@clientec.com>,
       <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Tue, 11 Jul 2006 20:27:07 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMMEJLDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-Reply-To: <20060707095441.GA3913@lnx-holt.americas.sgi.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The funniest part is that with memset commented out_of_memory observed,
contrary to my expectation.

I don't know why. It shouldn't have. I am running the application on an ARM
target.

Regards,
Abu.

-----Original Message-----
From: Robin Holt [mailto:holt@sgi.com]
Sent: Friday, July 07, 2006 3:25 PM
To: Abu M. Muttalib
Cc: kernelnewbies@nl.linux.org; linux-newbie@vger.kernel.org;
linux-kernel@vger.kernel.org; linux-mm
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()


I am not sure about x86, but on ia64, you would be very hard pressed
for this application to actually run you out of memory.  With the
memset commented out, you would be allocating vmas, etc, but you
would not be actually putting pages behind those virtual addresses.

Thanks,
Robin

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


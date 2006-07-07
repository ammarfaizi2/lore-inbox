Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWGKOnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWGKOnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWGKOnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:43:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25254 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750934AbWGKOnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:43:39 -0400
Date: Fri, 7 Jul 2006 04:54:41 -0500
From: Robin Holt <holt@sgi.com>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
Message-ID: <20060707095441.GA3913@lnx-holt.americas.sgi.com>
References: <BKEKJNIHLJDCFGDBOHGMAEBKDCAA.abum@aftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEBKDCAA.abum@aftek.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

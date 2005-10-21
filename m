Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVJUPLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVJUPLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVJUPLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:11:30 -0400
Received: from tardis.csc.ncsu.edu ([152.14.51.184]:63900 "EHLO
	tardis.csc.ncsu.edu") by vger.kernel.org with ESMTP id S964973AbVJUPLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:11:30 -0400
Message-ID: <4359051C.2070401@csc.ncsu.edu>
Date: Fri, 21 Oct 2005 11:11:24 -0400
From: "Vincent W. Freeh" <vin@csc.ncsu.edu>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1129903396.2786.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2005-10-21 at 09:45 -0400, Vincent W. Freeh wrote:
> 
>>Thanks for your quick response.  It basically confirmed that I observed 
>>what I thought I did.  However, I am no closer to solving my problem.  I 
>>cannot mprotect data that I malloc beyond the first 65 pages.
> 
> 
> you can't mprotect malloc() memory period ..

Actually, I can and do.  Simple program at end.

> 
>>  Why is 
>>that?  Can that be fixed?  Second, why does mprotect silently fail?  I 
>>could live with it failing--but I cannot deal with a call the "works" 
>>but doesn't work.
> 
> 
> need more info :)
> 

I call mprotect and it return 0--meaning it succeeded.  But the 
permissions on the page remain rw.  So it fails to change the 
permissions, but doesn't give any indication of this.

Thanks,
vince.

------------------
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
   void *p;
   int pgsize = getpagesize();

   p = malloc(1024);
   mprotect((void*)((unsigned)p & ~(pgsize-1)), 1024, PROT_NONE);
   printf("\t*p = %d\n", *(int *)p);
   return 0;
}

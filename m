Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbSJJGkA>; Thu, 10 Oct 2002 02:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbSJJGkA>; Thu, 10 Oct 2002 02:40:00 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:36827 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S263251AbSJJGjx>; Thu, 10 Oct 2002 02:39:53 -0400
Reply-To: <suresh.babu@wipro.com>
From: "Suresh babu V." <suresh.babu@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with sethostname() ??
Date: Thu, 10 Oct 2002 12:13:28 +0530
Organization: Wipro Technologies
Message-ID: <003d01c27028$5784a9f0$630b720a@sureshbabu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-db2acf37-6c1c-4dcb-9550-4c4ebac6c78c"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-db2acf37-6c1c-4dcb-9550-4c4ebac6c78c
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

	While attempting for some testing with sethostname() call, I got
this problem . As explained in the man page the sethostname call is
failing(ret val = -1 & errno = EFAULT(14)) for invalid address and valid
length. But the problem is after running the following test, hostname is
getting reset to NULL. I tested in both 2.4 & 2.5 kernels.

Any comments on this?? 

----------------------------------
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

main()
{
int ret, errno;
unsigned short int len;
char host[50]="tmphost"; /* hostname max size is 64 */
errno = 0;
len = sizeof(host); 

/* valid length and invalid address, expected err is EFAULT */
ret = sethostname((void *)-1, len);
printf("return val : %d, err no: %d \n",ret,errno);

} 
-------------------------------------------------

        I saw the code of sys_sethostname() function (sys.c) , in which
copy_from_user() is being called. I would like to know is it required to
validate the name argument before calling copy_from_user() to avoid such
problems.

        We could expect similar problem in setdomainname() also in which
same sort of code is used. 



PS : Please CC me your replies as I havn't subscribed to the list.
 
Thanks,
Suresh.


------=_NextPartTM-000-db2acf37-6c1c-4dcb-9550-4c4ebac6c78c
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-db2acf37-6c1c-4dcb-9550-4c4ebac6c78c--

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315849AbSEMGQl>; Mon, 13 May 2002 02:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315851AbSEMGQk>; Mon, 13 May 2002 02:16:40 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:11679 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S315849AbSEMGQj>; Mon, 13 May 2002 02:16:39 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Hotplug CPU prep III: daemonize idle tasks 
Date: Mon, 13 May 2002 11:49:08 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBEECLCIAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-fda73582-6632-11d6-a942-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E177597-0001TA-00@wagner.rustcorp.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-fda73582-6632-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Should __daemonize() check this? check if in the arguments
tsk == current or tsk == idle_task. This would prevent people
from using __daemonize() for the wrong things.

Balbir

|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org
|[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Rusty Russell
|Sent: Monday, May 13, 2002 7:31 AM
|To: BALBIR SINGH
|Cc: torvalds@transmeta.com; linux-kernel@vger.kernel.org
|Subject: Re: [PATCH] Hotplug CPU prep III: daemonize idle tasks
|
|
|In message <AAEGIMDAKGCBHLBAACGBAELNCHAA.balbir.singh@wipro.com> you write:
|> I tried a version of __daemonize in 2.4. It panics in
|> schedule()
|>
|>         prepare_to_switch();
|>         {
|>                 struct mm_struct *mm = next->mm;
|>                 struct mm_struct *oldmm = prev->active_mm;
|>                 if (!mm) {
|>                         if (next->active_mm) BUG();
|>
|> I got hit by the BUG() in 2.4, I think prepare_to_switch has
|> moved to specific archs in 2.5. A quick look showed that
|> this issue no longer exists in 2.5.
|
|Uhhh... there are many other problems if you are trying to do this on
|a "live" process.  idle process creation is a special case because it
|has never been run yet.
|
|This is not a generic "daemonize this task" mechanism!
|Rusty.
|--
|  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/


------=_NextPartTM-000-fda73582-6632-11d6-a942-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************
      


Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.



 ********************************************************************

------=_NextPartTM-000-fda73582-6632-11d6-a942-00b0d0d06be8--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWGIETg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWGIETg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 00:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWGIETg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 00:19:36 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:33514 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S964967AbWGIETf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 00:19:35 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.16.109):SA:0(-102.4/1.7):. Processed in 4.556827 secs Process 18767)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Robert Hancock" <hancockr@shaw.ca>, <chase.venters@clientec.com>
Cc: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Sun, 9 Jul 2006 09:53:46 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMCEEGDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <44AFF415.2020305@shaw.ca>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried with the /proc/sys/vm/overcommit_memory=2 and the system refused to
load the program altogether.

In this scenario is making overcommit_memory=2 a good idea?

Regards,
Abu.

-----Original Message-----
From: Robert Hancock [mailto:hancockr@shaw.ca]
Sent: Saturday, July 08, 2006 11:36 PM
To: Abu M. Muttalib
Cc: kernelnewbies@nl.linux.org; linux-newbie@vger.kernel.org;
linux-kernel@vger.kernel.org; linux-mm
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()


Abu M. Muttalib wrote:
> Hi,
>
> I am getting the Out of memory.
>
> To circumvent the problem, I have commented the call to "out_of_memory(),
> and replaced "goto restart" with "goto nopage".
>
> At "nopage:" lable I have added a call to "schedule()" and then "return
> NULL" after "schedule()".

Bad idea - in the configuration you have, the system may need the
out-of-memory killer to free up memory, otherwise the system can
deadlock due to all memory being exhausted.

>
> I tried the modified kernel with a test application, the test application
is
> mallocing memory in a loop. Unlike as expected the process gets killed. On
> second run of the same application I am getting the page allocation
failure
> as expected but subsequently the system hangs.
>
> I am attaching the test application and the log herewith.
>
> I am getting this exception with kernel 2.6.13. With kernel
> 2.4.19-rmka7-pxa1 there was no problem.
>
> Why its so? What can I do to alleviate the OOM problem?

Please see Documentation/vm/overcommit-accounting in the kernel source tree.

--
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/



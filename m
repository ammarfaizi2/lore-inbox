Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275301AbRJJLRa>; Wed, 10 Oct 2001 07:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbRJJLRU>; Wed, 10 Oct 2001 07:17:20 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:21155 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S275301AbRJJLRO>; Wed, 10 Oct 2001 07:17:14 -0400
Message-ID: <3BC42E65.3060706@wipro.com>
Date: Wed, 10 Oct 2001 16:47:57 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: landley@trommello.org
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: is reparent_to_init a good thing to do?
In-Reply-To: <3BC3118B.8050001@wipro.com> <3BC3223E.902FB7E@zip.com.au> <01100916261802.09423@localhost.localdomain>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rob Landley wrote:

>Or long lived kernel threads from short lived login sessions.
>
>You have a headless gateway box for your local subnet, administered via ssh 
>from a machine on the local subnet.  So you SSH into the box through eth1, 
>ifconfig eth0 down back up again.  If eth0 is an rtl8039too, this fires off a 
>kernel thread (which, before reparent_to_init, was parented to your ssh login 
>session).
>
>Now exit the login session.  SSH does not exit until all the child processes 
>exit, so it just hangs there until you kill it from another console window...
>
>Rob
>
The question one can ask is what should a thread do then?
Should reparent_to_init() send a SIGCHLD to the process/task
that was parent before init became the parent? this should be easy
to do, but will this fix the problem? I think so.

I can patch up something soon, if somebody is willing to test it.

comments,
Balbir




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRAaSDk>; Wed, 31 Jan 2001 13:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRAaSDU>; Wed, 31 Jan 2001 13:03:20 -0500
Received: from mirasta.antefacto.net ([193.120.245.10]:3084 "EHLO
	nt1.antefacto.com") by vger.kernel.org with ESMTP
	id <S129990AbRAaSDK>; Wed, 31 Jan 2001 13:03:10 -0500
Message-ID: <3A7852A9.1060600@AnteFacto.com>
Date: Wed, 31 Jan 2001 18:00:09 +0000
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Hanson <cph@zurich.ai.mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK
In-Reply-To: <E14O1Qe-00021Z-00@qiwi.ai.mit.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Hanson wrote:

>    Date: Wed, 31 Jan 2001 17:48:50 +0000
>    From: Padraig Brady <Padraig@AnteFacto.com>
> 
>    Are you using the 3c59x driver?
> 
> Yes.

Can we sort this out once and for all? There are a few emails
everyday relating to this bug.

The following patch posted by "Troels Walsted Hansen" <troels@thule.no>
on Jan 11th fixes this. The problem is that when 2 consequtive
NULLs are sent to klogd it goes into a busy loop. Andrew Mortons
3c59x driver does this, but also on Jan 11th he replied that he had
fixed it. I'm using 2.4ac4 with no problems, so I presume some
of these patches have been lost along the way?

--- sysklogd-1.4.orig/klogd.c    Mon Sep 18 09:34:11 2000
+++ sysklogd-1.4/klogd.c    Thu Jan 11 09:26:10 2001
@@ -739,6 +758,13 @@
            break;  /* full line_buff or end of input buffer */
                 }

+               if( *ptr == '\0' ) /* zero byte */
+               {
+                  ptr++;    /* skip zero byte */
+                  space -= 1;
+                  len   -= 1;
+                  break;
+               }
                 if( *ptr == '\n' )  /* newline */
                 {
                    ptr++;    /* skip newline */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbRDWPTx>; Mon, 23 Apr 2001 11:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135292AbRDWPTo>; Mon, 23 Apr 2001 11:19:44 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:26638 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S135283AbRDWPTh>; Mon, 23 Apr 2001 11:19:37 -0400
Message-ID: <3AE449A3.3050601@eisenstein.dk>
Date: Mon, 23 Apr 2001 17:26:27 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pedantic code cleanup - am I wasting my time with this?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I'm reading through various pieces of source code to try and get an 
understanding of how the kernel works (with the hope that I'll 
eventually be able to contribute something really usefull, but you've 
got to start somewhere ;)

While reading through the source I've stumbled across various bits and 
pieces that are not exactely wrong, but not strictly correct either. I 
was wondering if I would be wasting my time by cleaning this up or if it 
would actually be appreciated. One example of these things is the patch 
below:

--- linux-2.4.3-vanilla/include/linux/rtnetlink.h       Sun Apr 22 
02:29:20 2001
+++ linux-2.4.3/include/linux/rtnetlink.h       Mon Apr 23 17:09:02 2001
@@ -112,7 +112,7 @@
         RTN_PROHIBIT,           /* Administratively prohibited  */
         RTN_THROW,              /* Not in this table            */
         RTN_NAT,                /* Translate this address       */
-       RTN_XRESOLVE,           /* Use external resolver        */
+       RTN_XRESOLVE            /* Use external resolver        */
  };

  #define RTN_MAX RTN_XRESOLVE
@@ -278,7 +278,7 @@
  #define RTAX_CWND RTAX_CWND
         RTAX_ADVMSS,
  #define RTAX_ADVMSS RTAX_ADVMSS
-       RTAX_REORDERING,
+       RTAX_REORDERING
  #define RTAX_REORDERING RTAX_REORDERING
  };

@@ -501,7 +501,7 @@
         TCA_OPTIONS,
         TCA_STATS,
         TCA_XSTATS,
-       TCA_RATE,
+       TCA_RATE
  };

  #define TCA_MAX TCA_RATE


All the above does is to remove the last comma from 3 enumeration lists. 
I know that gcc has no problem with that, but to be strictly correct the 
last entry should not have a trailing comma.

Another example is the following line (1266) from linux/include/net/sock.h

         return (waitall ? len : min(sk->rcvlowat, len)) ? : 1;

To be strictly correct the second expression (between '?' and ':' ) 
should not be omitted (all you guys already know that ofcourse).

Would patches that clean up stuff like that be appreciated or am I just 
wasting my time?
Should I just adopt an 'if gcc -Wall does not complain then it's ok' 
attitude and leave this stuff alone?


Best regards,
Jesper Juhl - juhl@eisenstein.dk



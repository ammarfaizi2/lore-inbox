Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283269AbRK2PSZ>; Thu, 29 Nov 2001 10:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283266AbRK2PSQ>; Thu, 29 Nov 2001 10:18:16 -0500
Received: from marao.utad.pt ([193.136.40.3]:31244 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S283269AbRK2PSH>;
	Thu, 29 Nov 2001 10:18:07 -0500
Message-ID: <3C065182.3090909@alvie.com>
Date: Thu, 29 Nov 2001 15:17:22 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011127
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System temporary freeze (but network layer) while blanking CD-RW w/ ide-scsi [2.4.14 and 2.4.16 w/preempt]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

This is very weird. A few days ago I started blanking a CD-RW with a
HP9500 IDE drive and after five seconds or so the system froze. I was
still able to ping it and SNAT worked properly too. All services (X,
ssh, smtp) stopped and were almost fully inacessible (I was still able
to see some applets working on X, but no more) and when it finished
blanking, system came back to normal as if nothing had happended.

At the time I thought it might be a 2.4.14 issue.

Today I repeated the test with 2.4.16 w/ preemption patch. The same
thing happened. This time I was running a 'vmstat 1':

....
....
....
   0  4  1  50524   3932   2984  46168   0   0     0     0  102   151   0   0 100
   0  4  1  50524   3932   2984  46168   0   0     0     0  102   154   0   0 100
   0  4  1  50524   3928   2984  46168   0   0     0     0  101   149   0   0 100
   0  4  1  50524   3928   2984  46168   0   0     0     0  101   154   0   0 100
   1  4  1  50524   3928   2984  46168   0   0     0     0  101   150   0   0 100
   0  4  1  50524   3928   2984  46168   0   0     0     0  102   151   0   0 100
   0  4  1  50524   3924   2984  46168   0   0     0     0  101   156   0   0 100
   0  4  1  50524   3924   2984  46168   0   0     0     0  101   152   0   0 100
   0  4  1  50524   3924   2984  46168   0   0     0     0  102   155   0   0 100
   0  4  1  50524   3924   2984  46168   0   0     0     0  101   150   0   0 100
   0  4  1  50524   3916   2984  46168   0   0     0     0  101   150   0   0 100
   0  4  1  50524   3916   2984  46168   0   0     0     0  101   151   0   0 100

when it got here, system froze.... and then:

   1  5  1  50584   4216  2820  44996 2348 296 3032  348 113506 165193   0   0 100
   1  4  1  50572  11416   3192  37112 348   0   668   596  319  1243   4   3  93
   1  1  0  50552  11468   3520  37420   0   0   308   492  315   794   6   3  91
   1  0  0  50552  11068   3544  37596   0   0   168     4  127  9301  65   6  29
   1  0  0  50552  11064   3544  37596   0   0     0     0  104   652  75   0  25
   2  0  0  50552  11064   3544  37596   0   0     0     0  102   604  75   0  25
   1  0    procs                      memory    swap          io     system
     cpu
   r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
   1  0  1  50552  10992   3616  37596   0   0     0   140  154   721  75   1  25
   2  0  0  50552  10992   3616  37596   0   0     0    32  118   679  75   0  25
   1  0  0  50552  10988   3616  37596   0   0     0     0  101   610  75   0  25
   1  0  0  50552  10988   3616  37596   0   0     0     0  102   602  74   0  26
   0  0  0  50552  10104   3652  37664 220   0   308     0  139   741  47   1  52
   0  0  0  50552  10104   3652  37664   0   0     0     0  107   491   0   0 100
   0  0  0  50552  10012   3744  37664   0   0     0   160  155   598   1   0  99
   0  0  0  50552  10320   3744  37704  32   0    84     0  181  1078  18   2  80
   0  0  0  50552  10284   3780  37704   0   0     0    44  250   834   1   2  97


What is happening here ?  Any clues ???

Álvaro Lopes



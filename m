Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSCGAed>; Wed, 6 Mar 2002 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSCGAe0>; Wed, 6 Mar 2002 19:34:26 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24233 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288830AbSCGAeK>; Wed, 6 Mar 2002 19:34:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Futexes III : performance numbers
Date: Wed, 6 Mar 2002 19:35:05 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <E16iQrS-0005vY-00@wagner.rustcorp.com.au>
In-Reply-To: <E16iQrS-0005vY-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307003402.DBB263FE07@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 09:08 pm, Rusty Russell wrote:
> In message <20020305212210.B10A33FF04@smtp.linux.ibm.com> you write:

More on fairness. I hacked ulockflex to keep the history of lock acquisition 
and print it out after the run, so this doesn't create any overhead and
is recorded while the lock is held (history buffer is pretouched)

Read as follows
lock-aquisition   [ how often for the same process ] :   process id
                       left out if only 1

First the FUTEX_UP   later the FUTEX_UP_FAIR.
two cases (-r2 -x2) and (-r0 -x0)

Summary, its clearly seen how the fairness can be effected.
It also show the efficacy of FUTEX_UP and FUTEX_UP_FAIR.

Comments. 

./ulockflex -c 3 -a 1 -t 2 -o 5 -m 2 -R 499 -r 2 -x 1 -L f -H 2

===========================================================

(i.e.  2 usecs non-lockholdtime and 1 usec lockhold time)

----------------- UNFAIR LOCKS    == FUTEX_UP  ------------------
 <..snip...>
 1067602 [     4065 ]:     1
 1071667 [     4522 ]:     0
 1076189             :     2
 1076190 [      953 ]:     1
 1077143             :     2
 1077144 [     2875 ]:     0
 1080019 [     4800 ]:     2
 1084819             :     0
 1084820 [      968 ]:     1
 1085788             :     0
 1085789             :     1
 1085790             :     0
 1085791             :     1
 1085792             :     0
 1085793             :     1
 1085794             :     0
 1085795             :     1
 1085796             :     0
 1085797             :     1
 1085798             :     0
 1085799             :     1
 1085800             :     0
 1085801             :     1
 1085802             :     0
 1085803             :     1
 1085804             :     0
 1085805             :     1
 1085806             :     0
 1085807             :     1
 1085808             :     0
 1085809             :     1
 1085810             :     0
 1085811             :     1
 1085812             :     0
 1085813             :     2
 1085814 [        2 ]:     0
 1085816             :     2
 1085817 [     2861 ]:     1
 1088678             :     2
 1088679 [     4868 ]:     0
 1093547             :     2
 1093548 [      914 ]:     1
 1094462             :     2
 1094463 [     4829 ]:     0
 1099292             :     2
 1099293 [      963 ]:     1
 1100256             :     2
 1100257 [     4789 ]:     0
 1105046             :     2
 1105047 [      966 ]:     1
 1106013             :     2
 1106014 [     4800 ]:     0
 1110814             :     2
 1110815 [      961 ]:     1
 1111776             :     2
 1111777 [     2013 ]:     0
 1113790             :     2
 1113791             :     0
 1113792             :     2
 1113793 [     3768 ]:     1
 1117561             :     2
 1117562 [     4832 ]:     0
 1122394             :     2
 1122395 [      955 ]:     1
 1123350             :     2
 1123351 [     4813 ]:     0
 1128164             :     2
 1128165 [      982 ]:     1
 1129147             :     2
 1129148             :     1
 1129149             :     2
 1129150 [     4789 ]:     0
 1133939             :     2
 1133940             :     0
 1133941             :     2
 1133942             :     0
 1133943             :     2
 1133944 [      969 ]:     1
 1134913             :     2
 1134914 [     4841 ]:     0
 1139755             :     2
 1139756 [      967 ]:     1
 1140723             :     2
 1140724 [     4820 ]:     0
 1145544             :     2
 1145545 [      969 ]:     1
 1146514             :     2
 1146515 [     5007 ]:     0
 1151522             :     2
 1151523 [     3678 ]:     1
 1155201             :     2
 1155202 [     4756 ]:     0
 1159958             :     2
 1159959 [      978 ]:     1

--------------------------  FAIR LOCKS  == FUTEX_UP_FAIR  ----------------
  <... snip ...>
  558617             :     0
  558618             :     1
  558619             :     2
  558620             :     1
  558621             :     0
  558622             :     1
  558623             :     2
  558624             :     1
  558625             :     0
  558626             :     1
  558627             :     2
  558628             :     1
  558629             :     0
  558630             :     1
  558631             :     2
  <... and so on ....>

=================================================================.
/ulockflex -c 3 -a 1 -t 2 -o 5 -m 2 -R 499 -r 0 -x 0 -L f -H 2

===========================================================

(i.e.  0 usecs non-lockholdtime and 0 usec lockhold time)

----------------- UNFAIR LOCKS    == FUTEX_UP  ------------------
 <..snip...>
7682404 [     4593 ]:     1
 7686997             :     2
 7686998 [    16336 ]:     0
 7703334             :     2
 7703335 [    23875 ]:     1
 7727210 [        4 ]:     2
 7727214 [    20110 ]:     0
 7747324 [    13298 ]:     1
 7760622 [    11612 ]:     2
 7772234 [     8340 ]:     0
 7780574 [     6732 ]:     1
 7787306 [    13388 ]:     2
 7800694 [     3006 ]:     0
 7803700 [    17121 ]:     1
 7820821 [     6726 ]:     2
 7827547 [    13396 ]:     0
 7840943 [     6760 ]:     1
 7847703 [    13375 ]:     2
 7861078 [     4443 ]:     0
 7865521 [    15566 ]:     1
 7881087 [     6730 ]:     2
 7887817 [    13421 ]:     0
 7901238 [     3013 ]:     1
 7904251 [    16995 ]:     2
 7921246 [     6715 ]:     0
 7927961 [    13397 ]:     1
 7941358 [     6716 ]:     2
 7948074 [    13407 ]:     0
 7961481 [     6743 ]:     1
 7968224 [    13309 ]:     2
 7981533 [     6708 ]:     0
 7988241 [    13374 ]:     1
 8001615 [     3411 ]:     2
 8005026 [    16574 ]:     0
 8021600 [     7016 ]:     1

--------------------------  FAIR LOCKS  == FUTEX_UP_FAIR  ----------------
  <... snip ...>  same as for -r 2 -x 1




-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)


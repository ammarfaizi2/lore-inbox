Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311244AbSDAJ6l>; Mon, 1 Apr 2002 04:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311269AbSDAJ6c>; Mon, 1 Apr 2002 04:58:32 -0500
Received: from athena.asiansources.com ([202.160.251.142]:54157 "EHLO
	athena.asiansources.com") by vger.kernel.org with ESMTP
	id <S311244AbSDAJ6Y>; Mon, 1 Apr 2002 04:58:24 -0500
Message-ID: <3CA82F7F.312547B8@globalsources.com>
Date: Mon, 01 Apr 2002 17:59:27 +0800
From: Beng Asuncion <asmismn1@globalsources.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CLOSE_WAIT bug?
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear List,

We are using 2.4.17 kernel for our Production machines running JRun/Java
applications + Apache. We are encountering a lot of CLOSE_WAITs like the
following before our JRun applications die (port 53001 is the Jrun
port):

tcp        1      0 127.0.0.1:47185         127.0.0.1:53001
CLOSE_WAIT  32649/httpd
tcp        1      0 127.0.0.1:47119         127.0.0.1:53001
CLOSE_WAIT  32641/httpd
tcp        1      0 127.0.0.1:47283         127.0.0.1:53001
CLOSE_WAIT  32634/httpd
tcp     7661      0 127.0.0.1:48012         127.0.0.1:53001
CLOSE_WAIT  1051/httpd
tcp        1      0 127.0.0.1:48166         127.0.0.1:53001
CLOSE_WAIT  32663/httpd
tcp        1      0 127.0.0.1:46625         127.0.0.1:53001
CLOSE_WAIT  32640/httpd
tcp        1      0 127.0.0.1:46727         127.0.0.1:53001
CLOSE_WAIT  32667/httpd
tcp        1      0 127.0.0.1:51625         127.0.0.1:53001
CLOSE_WAIT  632/httpd
tcp        1      0 127.0.0.1:51623         127.0.0.1:53001
CLOSE_WAIT  32654/httpd
tcp        1      0 127.0.0.1:51374         127.0.0.1:53001
CLOSE_WAIT  1023/httpd
tcp        1      0 127.0.0.1:52010         127.0.0.1:53001
CLOSE_WAIT  32669/httpd
tcp        1      0 127.0.0.1:52168         127.0.0.1:53001
CLOSE_WAIT  32661/httpd
tcp        1      0 127.0.0.1:51774         127.0.0.1:53001
CLOSE_WAIT  32642/httpd
tcp     4125      0 127.0.0.1:52635         127.0.0.1:53001
CLOSE_WAIT  632/httpd
tcp        1      0 127.0.0.1:52651         127.0.0.1:53001
CLOSE_WAIT  404/httpd
tcp        1      0 127.0.0.1:52676         127.0.0.1:53001         CLOS
E_WAIT  32672/httpd
tcp        1      0 127.0.0.1:53046         127.0.0.1:53001
CLOSE_WAIT  410/httpd
tcp        1      0 127.0.0.1:52831         127.0.0.1:53001
CLOSE_WAIT  32643/httpd
tcp        1      0 127.0.0.1:52818         127.0.0.1:53001
CLOSE_WAIT  32660/httpd
tcp        1      0 127.0.0.1:49602         127.0.0.1:53001
CLOSE_WAIT  635/httpd
tcp        1      0 127.0.0.1:50028         127.0.0.1:53001
CLOSE_WAIT  631/httpd
tcp        1      0 127.0.0.1:50161         127.0.0.1:53001
CLOSE_WAIT  627/httpd
tcp        1      0 127.0.0.1:49896         127.0.0.1:53001
CLOSE_WAIT  633/httpd
tcp        1      0 127.0.0.1:50498         127.0.0.1:53001
CLOSE_WAIT  629/httpd
tcp        1      0 127.0.0.1:50496         127.0.0.1:53001
CLOSE_WAIT  32658/httpd
tcp        1      0 127.0.0.1:50947         127.0.0.1:53001
CLOSE_WAIT  372/httpd
tcp        1      0 127.0.0.1:50754         127.0.0.1:53001
CLOSE_WAIT  626/httpd
tcp        1      0 127.0.0.1:55640         127.0.0.1:53001
CLOSE_WAIT  32666/httpd
tcp     4718      0 127.0.0.1:55638         127.0.0.1:53001
CLOSE_WAIT  626/httpd
tcp        1      0 127.0.0.1:55791         127.0.0.1:53001
CLOSE_WAIT  4237/httpd
tcp        1      0 127.0.0.1:56074         127.0.0.1:53001
CLOSE_WAIT  3300/httpd
tcp        1      0 127.0.0.1:56100         127.0.0.1:53001
CLOSE_WAIT  32657/httpd
tcp        1      0 127.0.0.1:55893         127.0.0.1:53001
CLOSE_WAIT  32632/httpd
tcp        1      0 127.0.0.1:56621         127.0.0.1:53001
CLOSE_WAIT  403/httpd
tcp        1      0 127.0.0.1:56758         127.0.0.1:53001
CLOSE_WAIT  628/httpd
tcp     8596      0 127.0.0.1:56826         127.0.0.1:53001
CLOSE_WAIT  635/httpd
tcp        1      0 127.0.0.1:56438         127.0.0.1:53001
CLOSE_WAIT  32665/httpd
tcp        1      0 127.0.0.1:57266         127.0.0.1:53001
CLOSE_WAIT  4242/httpd
tcp     4718      0 127.0.0.1:56904         127.0.0.1:53001
CLOSE_WAIT  32659/httpd
tcp        1      0 127.0.0.1:56980         127.0.0.1:53001
CLOSE_WAIT  32671/httpd
tcp        1      0 127.0.0.1:57003         127.0.0.1:53001
CLOSE_WAIT  32664/httpd
tcp    18867      0 127.0.0.1:57052         127.0.0.1:53001
CLOSE_WAIT  32648/httpd
tcp        1      0 127.0.0.1:53407         127.0.0.1:53001
CLOSE_WAIT  32638/httpd
tcp        1      0 127.0.0.1:53402         127.0.0.1:53001
CLOSE_WAIT  32659/httpd
tcp        1      0 127.0.0.1:53439         127.0.0.1:53001
CLOSE_WAIT  32668/httpd
tcp        1      0 127.0.0.1:54162         127.0.0.1:53001
CLOSE_WAIT  32650/httpd
tcp    49403      0 127.0.0.1:54172         127.0.0.1:53001
CLOSE_WAIT  32666/httpd
tcp        1      0 127.0.0.1:53783         127.0.0.1:53001
CLOSE_WAIT  32662/httpd
tcp        1      0 127.0.0.1:54408         127.0.0.1:53001
CLOSE_WAIT  634/httpd
tcp        1      0 127.0.0.1:54451         127.0.0.1:53001
CLOSE_WAIT  32633/httpd
tcp    21285      0 127.0.0.1:55113         127.0.0.1:53001
CLOSE_WAIT  4241/httpd
tcp        1      0 127.0.0.1:57400         127.0.0.1:53001
CLOSE_WAIT  4236/httpd
tcp        1      0 127.0.0.1:57463         127.0.0.1:53001
CLOSE_WAIT  32644/httpd
tcp        1      0 127.0.0.1:57456         127.0.0.1:53001
CLOSE_WAIT  32670/httpd
tcp        1      0 127.0.0.1:57584         127.0.0.1:53001
CLOSE_WAIT  4233/httpd

CLOSE_WAIT_for_OTHERS
     12
tcp        1  14600 192.168.66.178:80       203.123.134.34:21244
CLOSE_WAIT  4241/httpd
tcp        1  12847 192.168.66.178:80       205.188.199.187:5396
CLOSE_WAIT  32666/httpd
tcp        1  13600 192.168.66.178:80       205.188.193.33:29005
CLOSE_WAIT  4238/httpd
tcp        1  13006 192.168.66.178:80       205.188.199.187:10542
CLOSE_WAIT  635/httpd
tcp        1  12771 192.168.66.178:80       205.188.192.184:23366
CLOSE_WAIT  5330/httpd
tcp        1  12447 192.168.66.178:80       205.188.199.187:10090
CLOSE_WAIT  4243/httpd
tcp        1  12770 192.168.66.178:80       205.188.192.184:25710
CLOSE_WAIT  628/httpd
tcp        1  10720 192.168.66.178:80       193.110.211.66:12136
CLOSE_WAIT  632/httpd
tcp        1  14600 192.168.66.178:80       203.127.108.3:51958
CLOSE_WAIT  5331/httpd
tcp        1  14600 192.168.66.178:80       203.127.108.3:40387
CLOSE_WAIT  32648/httpd
tcp        1  14437 192.168.66.178:80       210.49.245.134:15251
CLOSE_WAIT  626/httpd
tcp        1  13590 192.168.66.178:80       210.180.96.11:6364
CLOSE_WAIT  5377/httpd

---------------------------------

The developers have hinted that it could be a problem of the kernel,
refering me to the link below:

http://www.cs.helsinki.fi/linux/linux-kernel/2001-23/0424.html

It seems that the link referred to kernels 2.2.19 and 2.4.5 . Would
anyone be able to verify/confirm that this "BUG"(?) has already been
fixed on 2.4.17 and up?  I followed the thread on the mailing list and
it looked like the messages stopped on this reponse from Andi Kleen.

Any info to shed light on this would be very much appreciated.

Regards,
Beng


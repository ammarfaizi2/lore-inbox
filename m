Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319548AbSIMH5k>; Fri, 13 Sep 2002 03:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319549AbSIMH5k>; Fri, 13 Sep 2002 03:57:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6926 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S319548AbSIMH5k>; Fri, 13 Sep 2002 03:57:40 -0400
Message-Id: <200209130757.g8D7vxp09323@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Jim Sibley" <jlsibley@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
Date: Fri, 13 Sep 2002 10:53:00 -0200
X-Mailer: KMail [version 1.3.2]
Cc: riel@conectiva.com.br, ltc@linux.ibm.com, "Troy Reed" <tdreed@us.ibm.com>
References: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
In-Reply-To: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 September 2002 16:08, Jim Sibley wrote:
>                                     resource
>      group                          priority                kill priority
>      system                         0                       0 - never kill
>      support                        1                       1
>      payroll                        2                       2
>      production                     3                       3
>      general user                   4                       4
>      production backgournd          5                       3   
                                                             ^^^ 
                                 make sure testing and general user are killed
                                 BEFORE production
>      testing                        6                       5


I like this. Maybe map it to user gid and provide /proc interface?

Let's say on your server you allocated gids this way:
0   -   system
100 -   support
110 -   payroll
120 -   production
200 -  general user
130 -   production background
500 - testing

# echo "0 100 110 120 200 130 500" >/proc/resourceprio
# echo "0 100 110 120 130 200 500" >/proc/killprio
--
vda

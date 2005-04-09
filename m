Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVDIAjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDIAjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDIAjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:39:10 -0400
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:11475 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S261178AbVDIAi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:38:59 -0400
Message-ID: <4257247B.8030604@pin.if.uz.zgora.pl>
Date: Sat, 09 Apr 2005 02:40:27 +0200
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Michael Thonke <tk-shockwave@web.de>
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since
 2.6.12-rc1[mm1-4]
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl>	 <424D71DE.5060703@web.de> <424D91B5.50404@pin.if.uz.zgora.pl>	 <424D9A9C.2070705@web.de>  <424D9FCE.6020200@pin.if.uz.zgora.pl> <1112993039.12025.65.camel@eeyore>
In-Reply-To: <1112993039.12025.65.camel@eeyore>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> On Fri, 2005-04-01 at 21:23 +0200, Jacek Luczak wrote:
> 
>>Michael Thonke napisa³(a):
>>
>>>Hello Jacek,
>>>
>>>I finially got it working :-) my PCI-Express devices working now...
>>>I grabbed the last bk-snapshot from kernel.org 2.6.12-rc1-bk3 and et volia
>>>everything except the Marvell Yokon PCI-E device working.
>>>I hope Andrew will look into the mm-line to find the bug?
>>>
>>
>>I've got Marvell Yukon 88E8053 GigE and it works fine with fixed (by 
>>myself :]) driver from syskonnect. If you wont I may send it to you!
> 
> 
> Please post your patch here and copy the maintainers:
> 
> MARVELL YUKON / SYSKONNECT DRIVER
> P:      Mirko Lindner
> M:      mlindner@syskonnect.de
> P:      Ralph Roesler
> M:      rroesler@syskonnect.de
> W:      http://www.syskonnect.com
> S:      Supported
> 
> 
> 

Hi

I sent my patch to Mirko about 3 weeks ago. Mirko replied that he
consider it. Since that time new version of sk98lin driver appeared.

Version from syskonnect site require only changing usage of
pci_dev->slot_name to pci_name(pci_dev) in skge.c and skethtool.c. After
that everything should work fine. So I think there is no need to post my
path here but if you really whant I may do this. Whole path agains
2.6.12-rc2 take about 1.2 MB (diffstat attached below).


	Jacek
---

 drivers/net/Kconfig               |  113 -
 drivers/net/sk98lin/Makefile      |   64
 drivers/net/sk98lin/h/lm80.h      |    4
 drivers/net/sk98lin/h/skaddr.h    |    4
 drivers/net/sk98lin/h/skcsum.h    |    6
 drivers/net/sk98lin/h/skdebug.h   |   20
 drivers/net/sk98lin/h/skdrv1st.h  |   41
 drivers/net/sk98lin/h/skdrv2nd.h  |  978 ++++++---
 drivers/net/sk98lin/h/skerror.h   |   12
 drivers/net/sk98lin/h/skgedrv.h   |    4
 drivers/net/sk98lin/h/skgehw.h    | 1377 ++++++++++---
 drivers/net/sk98lin/h/skgehwt.h   |    4
 drivers/net/sk98lin/h/skgei2c.h   |  210 --
 drivers/net/sk98lin/h/skgeinit.h  |  369 ++-
 drivers/net/sk98lin/h/skgepnm2.h  |   12
 drivers/net/sk98lin/h/skgepnmi.h  |  141 -
 drivers/net/sk98lin/h/skgesirq.h  |   40
 drivers/net/sk98lin/h/skgetwsi.h  |  241 ++
 drivers/net/sk98lin/h/ski2c.h     |  177 -
 drivers/net/sk98lin/h/skqueue.h   |   13
 drivers/net/sk98lin/h/skrlmt.h    |    4
 drivers/net/sk98lin/h/sktimer.h   |    4
 drivers/net/sk98lin/h/sktwsi.h    |  177 +
 drivers/net/sk98lin/h/sktypes.h   |   62
 drivers/net/sk98lin/h/skversion.h |   34
 drivers/net/sk98lin/h/skvpd.h     |   84
 drivers/net/sk98lin/h/sky2le.h    |  891 ++++++++
 drivers/net/sk98lin/h/xmac_ii.h   |  621 +++---
 drivers/net/sk98lin/sk98lin.txt   |  203 +-
 drivers/net/sk98lin/skaddr.c      |   79
 drivers/net/sk98lin/skcsum.c      |    6
 drivers/net/sk98lin/skdim.c       | 1027 +++-------
 drivers/net/sk98lin/skethtool.c   | 1379 ++++++++++---
 drivers/net/sk98lin/skge.c        | 3779
++++++++++++++++++++++++--------------
 drivers/net/sk98lin/skgehwt.c     |   52
 drivers/net/sk98lin/skgeinit.c    | 1683 ++++++++++++----
 drivers/net/sk98lin/skgemib.c     |  186 +
 drivers/net/sk98lin/skgepnmi.c    | 2282 +++++++++++-----------
 drivers/net/sk98lin/skgesirq.c    | 1244 +++++++-----
 drivers/net/sk98lin/ski2c.c       | 1296 -------------
 drivers/net/sk98lin/sklm80.c      |   10
 drivers/net/sk98lin/skproc.c      |  587 ++++-
 drivers/net/sk98lin/skqueue.c     |  103 -
 drivers/net/sk98lin/skrlmt.c      |  258 +-
 drivers/net/sk98lin/sktimer.c     |   61
 drivers/net/sk98lin/sktwsi.c      | 1355 +++++++++++++
 drivers/net/sk98lin/skvpd.c       |  195 +
 drivers/net/sk98lin/skxmac2.c     | 2235 +++++++++++++---------
 drivers/net/sk98lin/sky2.c        | 2728 +++++++++++++++++++++++++++
 drivers/net/sk98lin/sky2le.c      |  510 +++++
 50 files changed, 18204 insertions(+), 8761 deletions(-)

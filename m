Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTIVKLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 06:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTIVKLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 06:11:41 -0400
Received: from eregon.isg.com.br ([200.216.72.177]:38022 "EHLO isg.com.br")
	by vger.kernel.org with ESMTP id S263007AbTIVKLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 06:11:39 -0400
Message-ID: <3F6ECEC8.6040807@isg.com.br>
Date: Mon, 22 Sep 2003 07:28:24 -0300
From: Rodrigo Miranda Terra <rodrigo@isg.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: patch-2.4.23-pre5 and pcmcia services
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I´m wrinting only to report that the new releases that start with 
patch-2.4.23-pre1 broken pcmcia support from pcmcia_cs packages. The 
error of not compile  pcmcia_cs is easy to correct only and #define 
CONFIG_NR_CPUS  in include/pcmcia/autoconf.h  (  pcmcia 2.3.5 ) or 
include/pcmcia/config.h ( in pcmcia_cs 2.3.4 ). But the problem is that 
result modules cant find devices.
     If I repeat exact the same process with 2.4.22 all work fine!  The 
motherboard that I tested was a A7S333. The device is a SWL-2100 ( 
Samsung 802.11b - Wireless board ). I was using with hostap driver. The 
pcmcia can find device and even locate right module and try load the 
module but cant bind. Below a except from /var/log/daemond.log:

Sep 21 12:36:03 eregon cardmgr[201]: watching 4 sockets
Sep 21 12:36:03 eregon cardmgr[201]: starting, version is 3.2.5
Sep 21 12:36:04 eregon cardmgr[201]: socket 0: Samsung SWL2000-N 11Mb/s 
WLAN Card
Sep 21 12:36:04 eregon cardmgr[201]: executing: 'modprobe hostap_crypt'
Sep 21 12:36:04 eregon cardmgr[201]: executing: 'modprobe hostap'
Sep 21 12:36:04 eregon cardmgr[201]: executing: 'modprobe hostap_cs'
Sep 21 12:36:04 eregon cardmgr[201]: bind 'hostap_cs' to socket 0 
failed: Operation not permitted

      If I change ds.c in pcmcia package to ignore bind error i get :

Sep 21 20:46:16 eregon cardmgr[208]: get dev info on socket 0 failed: No 
such device

   My distribution is debian woody. I´m using now 2.4.22 with some 
patchs borrowed from 2.4.23-pre5, like  sch_htb.c  fix. Any way I would 
like report this problem.


Regards Rodrigo.



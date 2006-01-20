Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWATL1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWATL1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWATL1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:27:51 -0500
Received: from general.keba.co.at ([193.154.24.243]:11935 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750850AbWATL1u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:27:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: My vote against eepro* removal
Date: Fri, 20 Jan 2006 12:27:43 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323327@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYdsXS2Bwg2wUppRyOBEcizqJmEugAAjCyw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Cc: "John Ronciak" <john.ronciak@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Lee Revell" <rlrevell@joe-job.com>, <linux-kernel@vger.kernel.org>,
       <john.ronciak@intel.com>, <ganesh.venkatesan@intel.com>,
       <jesse.brandeburg@intel.com>, <netdev@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov
> Just a hack:
> 
> --- drivers/net/e100.c.1	2006-01-20 13:39:19.000000000 +0300
> +++ drivers/net/e100.c	2006-01-20 14:15:40.000000000 +0300
> @@ -879,8 +879,8 @@
>  
>  	writel((reg << 16) | (addr << 21) | dir | data, 
> &nic->csr->mdi_ctrl);
>  
> -	for(i = 0; i < 100; i++) {
> -		udelay(20);
> +	for(i = 0; i < 1000; i++) {
> +		udelay(2);
>  		if((data_out = readl(&nic->csr->mdi_ctrl)) & mdi_ready)
>  			break;
>  	}

My test environment and software is not precise enough for small 
improvements, but I'd say this results in a 10-15 % improvement
(i.e. something like 50 us shorter delay) on the average.

To be sure, one would have to take and print tsc timestamps directly
in the watchdog code, but printk's mess up my timings.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com

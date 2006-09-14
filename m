Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWINFX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWINFX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 01:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWINFX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 01:23:28 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:54991 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S1751342AbWINFX1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 01:23:27 -0400
Date: Thu, 14 Sep 2006 13:23:26 +0800
From: "Yingchao Zhou" <yc_zhou@ncic.ac.cn>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "zxc" <zxc@ncic.ac.cn>, "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [RFC] PAGE_RW Should be added to PAGE_COPY ?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20060914052328.8B4AFFB044@ncic.ac.cn>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's OK to lock the page for the NIC driver. But I think it is an OS flaw to 
clear the _PAGE_RW bit for ptes in the mprotected space. If the _PAGE_RW is set, it 
should not get to do_wp_page.

Best regards
>Your analysis is correct. But locking a page to avoid swap has different
>meaning with page locked (TestSetPageLocked()). Looks you missed this.
>
>Thanks,
>Shaohua
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Yingchao Zhou
>Sent: Wednesday, September 13, 2006 10:03 PM
>To: linux-kernel
>Cc: akpm; alan; zxc
>Subject: [RFC] PAGE_RW Should be added to PAGE_COPY ?
>
>
>     The current kernel set PAGE_COPY without write bit. This will cause
>intermittent non-cosistent data for user-level network drivers such as
>Infiniband, Quadrics and Myrinet. Which has also be mentioned by Costin
>Iancu in the paper "HUNTing the Overlap " (PACT'05).
>    An example of such phenomena is the following sequences: 
>	register a memory space BUFF for receive message, 
>	receive message,
>	call mprotect(...PROT_NONE...) and
>mprotect(...PROT_READ|PROT_WRITE) one by one, 	
>	write into BUFF, 
>	then receive again.      
>    The second time received data will perhaps not be the data sent by
>the peer machine but the data written by itself in the 4th step.
>
>     The reson is that :
>     1) User-level network driver locks phy pages when memory space is
>registered;
>........

___________________________________________________
_      Yingchao Zhou                              _
_      ICT, CAS                                   _
_      (86)010-62601009                           _
___________________________________________________




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264710AbRGDNvm>; Wed, 4 Jul 2001 09:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbRGDNvc>; Wed, 4 Jul 2001 09:51:32 -0400
Received: from gw-nl4.philips.com ([212.153.190.6]:50442 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S264663AbRGDNvR>; Wed, 4 Jul 2001 09:51:17 -0400
From: fabrizio.gennari@philips.com
Subject: dev_get_by_name without dev_put
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Jul 2001 15:49:46 +0200
Message-ID: <OF870A7F74.AB18863F-ONC1256A7F.004AB8A1@diamond.philips.com>
X-MIMETrack: Serialize by Router on EMAUO01/H/SERVER/PHILIPS(Release 5.0.5 |September 22, 2000) at
 04/07/2001 16:04:10
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time dev_get_by_name is called, and it has returned a valid struct net_device*, dev_put should be called afterwards, because otherwise the machine hangs when the device is unregistered (since dev->refcnt > 1). However, it seems that some drivers do
not call dev_put after dev_get_by_name: for example, drivers/net/pppoe.c at line 573 and net/core/dv.c at line 168. Am I wrong?
---------------------------------------------------------
Fabrizio Gennari          tel. +39 039 203 7816
Philips Research Monza    fax. +39 039 203 7800
via G. Casati 23          fabrizio.gennari@philips.com
20052 Monza (MI) Italy    http://www.research.philips.com


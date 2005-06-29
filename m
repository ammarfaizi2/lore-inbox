Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVF2OQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVF2OQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVF2OPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:15:22 -0400
Received: from mx15.sac.fedex.com ([199.81.195.17]:9746 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S262585AbVF2OPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:15:08 -0400
Date: Wed, 29 Jun 2005 22:17:06 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alejandro Bonilla <abonilla@linuxwireless.org>
cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jeff Chua'" <jeff96@silk.corp.fedex.com>,
       ipw2100-devel@lists.sourceforge.net,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: ipw2200 can't compile under linux 2.6.13-rc1
In-Reply-To: <001101c57ca8$30c7d640$600cc60a@amer.sykes.com>
Message-ID: <Pine.LNX.4.63.0506292209050.6581@boston.corp.fedex.com>
References: <001101c57ca8$30c7d640$600cc60a@amer.sykes.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/29/2005
 10:15:00 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/29/2005
 10:15:03 PM,
	Serialize complete at 06/29/2005 10:15:03 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Alejandro Bonilla wrote:

>>> ipw2200-1.0.4 can't be compiled under linux 2.6.13-rc1.
>> soo..... what's the error ?
>
> Probably the same reason why it won't compile in 2.6.12.

Sorry for not being specific. I managed to trace down the problem to the 
new patch. linux 2.6.13-rc1 created a new file include/net/ieee80211.h
and there's an existing file in the ipw2200 directory with the same 
name ieee80211.h.

All the ipw2200 files has ...

 	#include <net/ieee80211.h>

and that points to the new linux header in 
/usr/src/linux/include/net/ieee80211.h instead of the local include file 
under the ipw2200/net directory.

I've modified all ipw2200 files to #include "net/ieee80211.h" and now it 
compiles ok.

Thanks,
Jeff.

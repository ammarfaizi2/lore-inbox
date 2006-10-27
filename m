Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWJ0W45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWJ0W45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJ0W45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:56:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:24961 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750833AbWJ0W44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:56:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=U+qvcl1xabvyCnrbY4nJnh1JW8HpB/GndvF5opvoecoSCHycwKyMHLyJRg5R4m86noPyF01syGiz/VvxkR81oPHzpPtWS2q8dRXJyuxrOQDZwAEszuFZqgUXWyBobLbrB6RKtFrAwIIFa9I5Zbd0eDEA9BDgnLOUDCa9BdAZL1I=
Message-ID: <45428EAD.6040005@gmail.com>
Date: Fri, 27 Oct 2006 18:56:45 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Randy Dunlap <randy.dunlap@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       proski@gnu.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, cate@debian.org,
       gianluca@abinetworks.biz
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain>	<20061025205923.828c620d.akpm@osdl.org>	<20061026102630.ad191d21.randy.dunlap@oracle.com>	<1161959020.12281.1.camel@laptopd505.fenrus.org>	<20061027082741.8476024a.randy.dunlap@oracle.com> <20061027112601.dbd83c32.akpm@osdl.org>
In-Reply-To: <20061027112601.dbd83c32.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 27 Oct 2006 08:27:41 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>   
>> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
>> ---
>>  kernel/module.c |    2 +-
>>  1 files changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-2619-rc3-pv.orig/kernel/module.c
>> +++ linux-2619-rc3-pv/kernel/module.c
>> @@ -1718,7 +1718,7 @@ static struct module *load_module(void _
>>  	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>>  
>>  	if (strcmp(mod->name, "ndiswrapper") == 0)
>> -		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>> +		add_taint(TAINT_PROPRIETARY_MODULE);
>>  	if (strcmp(mod->name, "driverloader") == 0)
>>  		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>>  
>>     
>
> Could someone please test this for us?
>   

Tested, works (ndiswrapper 1.27).

Also, since driverloader is not GPL-compatible (MODULE_LICENSE("see
LICENSE file; Copyright (c)2003-2004 Linuxant inc.")), that check is
redundant. How about removing it (applies on top of Randy's patch)?


Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 module.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 67009bd..293eb4c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1719,8 +1719,6 @@ #endif
 
 	if (strcmp(mod->name, "ndiswrapper") == 0)
 		add_taint(TAINT_PROPRIETARY_MODULE);
-	if (strcmp(mod->name, "driverloader") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);



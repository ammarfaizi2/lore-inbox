Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEIRNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEIRNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEIRNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:13:04 -0400
Received: from main.gmane.org ([80.91.229.2]:16022 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750760AbWEIRNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:13:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Schweizer <genstef@gentoo.org>
Subject: Re: [PATCH 2.6.17-rc3] Fix capi reload by unregistering the correct major
Followup-To: gmane.linux.kernel
Date: Tue, 09 May 2006 19:12:14 +0200
Message-ID: <e3qihe$3q2$1@sea.gmane.org>
References: <e307i4$f1h$1@sea.gmane.org> <20060508130029.08a9a962.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-62-245-211-185.mnet-online.de
User-Agent: KNode/0.10.2
Cc: i4ldeveloper@listserv.isdn4linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Stefan Schweizer <genstef@gentoo.org> wrote:
>> --- drivers/isdn/capi/capi.c.orig    2006-04-29 18:40:25.000000000 +0200
>> +++ drivers/isdn/capi/capi.c 2006-04-29 18:27:22.000000000 +0200
>> @@ -1499,7 +1499,6 @@
>>  printk(KERN_ERR "capi20: unable to get major %d\n", capi_major);
>>  return major_ret;
>>  }
>> -    capi_major = major_ret;
>>  capi_class = class_create(THIS_MODULE, "capi");
>>  if (IS_ERR(capi_class)) {
>>  unregister_chrdev(capi_major, "capi20");
>> 
>> 
>> 
> 
> What does "unload and retry" mean?
> 
> An `rmmod capi;modprobe capi' will reset the major to 68, so you must mean
> something else.  What?

I mean exactly rmmod capi; modprobe capi. The problem is, that on unload
time, the capi_major has been set to major_ret, which is 0 if a major
number is given. Of course it does not unregister 68 then. Consequently
when trying to load it a second time after unloading it fails, because it
has not freed the major 68.

Regards,
Stefan


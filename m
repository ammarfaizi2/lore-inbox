Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUCJTMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUCJTMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:12:40 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:3466 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262788AbUCJTL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:11:56 -0500
Message-ID: <404F687A.7040301@acm.org>
Date: Wed, 10 Mar 2004 13:11:54 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Davis, Todd C" <todd.c.davis@intel.com>, greg@kroah.com,
       sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de>
In-Reply-To: <20040310185105.GS14833@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>The patch to i2c-core.c is strange:
>
>
>  
>
>>--- linux-v31/drivers/i2c/i2c-core.c	2004-02-19 19:31:07.000000000 -0600
>>+++ linux/drivers/i2c/i2c-core.c	2004-03-10 09:48:08.000000000 -0600
>>@@ -1256,6 +1256,12 @@
>> 	return (func & adap_func) == func;
>> }
>> 
>>+int i2c_spin_delay;
>>+void i2c_set_spin_delay(int val)
>>+{
>>+	i2c_spin_delay = val;
>>+}
>>+
>> EXPORT_SYMBOL(i2c_add_adapter);
>> EXPORT_SYMBOL(i2c_del_adapter);
>> EXPORT_SYMBOL(i2c_add_driver);
>>@@ -1292,6 +1298,8 @@
>> 
>> EXPORT_SYMBOL(i2c_get_functionality);
>> EXPORT_SYMBOL(i2c_check_functionality);
>>+EXPORT_SYMBOL(i2c_set_spin_delay);
>>+EXPORT_SYMBOL(i2c_spin_delay);
>> 
>> MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
>> MODULE_DESCRIPTION("I2C-Bus main module");
>>...
>>    
>>
>
>
>You can either add get/set functions and export them (more an OO 
>paradigm) or export the variable.
>
>If you export the variable, it's quite useless to add such a set 
>function since everyone can set the variable directly.
>
I think the point is that lower-level drivers need to use this variable 
(because of its use in the include file), but it's better to set it with 
a function from external code.

Todd, am I correct here?

-Corey


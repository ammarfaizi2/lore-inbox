Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTLQUXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTLQUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:23:36 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26262 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264538AbTLQUXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:23:34 -0500
Message-ID: <3FE0BC4D.8080605@us.ltcfwd.linux.ibm.com>
Date: Wed, 17 Dec 2003 14:27:57 -0600
From: Linda Xie <lxiep@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linda Xie <lxiep@us.ibm.com>, linux-kernel@vger.kernel.org,
       scheel@us.ibm.com, wortman@us.ibm.com
Subject: Re: PATCPATCH -- add unlimited name lengths support to sysfs
References: <3FDF902A.4000903@us.ltcfwd.linux.ibm.com> <20031216231447.GA4781@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Dec 16, 2003 at 05:07:22PM -0600, Linda Xie wrote:
> 
>>diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
>>--- a/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
>>+++ b/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
>>@@ -42,7 +42,10 @@
>> 	struct kobject * p = kobj;
>> 	int length = 1;
>> 	do {
>>-		length += strlen(p->name) + 1;
>>+		if (p->k_name)
>>+			length += strlen(p->k_name) + 1;
>>+		else
>>+			length += strlen(p->name) + 1;
> 
> 
> Shouldn't this just be:
> 		length += strlen(kobject_name(p)) + 1;
> 

That is correct. But here is my concern: Some of the callers of 
sysfs_create_link()
set p->name instead of p->k_name. So for them, the length calculated 
using kobject_name(p) will be incorrect. Correct me if I am wrong.

Thanks,

Linda

> 
>>@@ -54,11 +57,20 @@
>>
>> 	--length;
>> 	for (p = kobj; p; p = p->parent) {
>>-		int cur = strlen(p->name);
>>-
>>+		int cur;
>>+		char *name;
>>+		
>>+		if (p->k_name) {
>>+			cur = strlen(p->k_name);
>>+			name = p->k_name;
>>+		}
>>+		else {
>>+			cur = strlen(p->name);
>>+			name = p->name;
>>+		}
> 
> 
> Same here, just use kobject_name() to get the proper pointer.
> 
> thanks,
> 
> greg k-h


Thanks,

Linda


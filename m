Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTEaUTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTEaUTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:19:12 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:34467 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S264429AbTEaUTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:19:11 -0400
Message-ID: <3ED91161.1050603@cox.net>
Date: Sat, 31 May 2003 13:32:33 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "ismail (cartman) donmez" <kde@myrealbox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
References: <3ED8D5E4.6030107@cox.net> <200305312325.07809.kde@myrealbox.com>
In-Reply-To: <200305312325.07809.kde@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail (cartman) donmez wrote:

> On Saturday 31 May 2003 19:18, Kevin P. Fleming wrote:
> 
>>Changes during 2.5.70 added _user tags to various bits in
>>include/linux/sysctl.h. __user is defined in linux/compiler.h, which is
>>included by linux/kernel.h but only if __KERNEL__ is defined. Compiliing
>>uClibc against 2.5.70 fails because __user__ is not defined.
>>
>>Adding patch below solves the problem (yes, I know, userspace is not
>>supposed to use kernel headers...)
>>
>>--- linux-2.5/include/linux/sysctl.h~	Sat May 31 08:52:49 2003
>>+++ linux-2.5/include/linux/sysctl.h	Sat May 31 09:04:29 2003
>>@@ -27,6 +27,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/types.h>
>>  #include <linux/list.h>
>>+#include <linux/compiler.h>
>>
>>  struct file;
> 
> 
> linux/kernel.h includes <linux/compiler.h>.
> 

See the beginning of my message... it only does so if _KERNEL_ is 
defined. Since other header files also directly include compiler.h even 
though they already include kernel.h, I didn't think this was an 
unreasonable solution (i.e. they must have done it for the same reason, 
since there are comments specifically about including compiler.h for 
"__user").


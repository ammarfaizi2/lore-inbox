Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTDJKft (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTDJKft (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 06:35:49 -0400
Received: from wotug.org ([194.106.52.201]:38187 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id S264021AbTDJKfs (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 06:35:48 -0400
Message-Id: <5.2.0.9.0.20030410114713.01ef2110@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 10 Apr 2003 11:47:28 +0100
To: linux-kernel@vger.kernel.org
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: kernel support for non-english user messages
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:55 09/04/2003, you wrote:
> > "My suggestion would be to add the required i18n support to klogd, so
> > that kernel messages are translated as they are removed from dmesg into
> > syslog. Then, like any i18n support,
>
>This is _not_ like any i18n support.  The problem is that normal

Agreed. How about changing the way printk works, so that instead of 
combining the format string, it just "prints" its args:

printk("%s: name %p is %d\n", name, ptr, val);

results in the following in the kernel buffer:

"%s: name %p is %d\n", "stringval", 0x4790243, 44


Then run a process to either push them together again (native mode) or do 
the getmsg() thing for i18n mode?

Only problem I can see is early-boot, where the normal demons can't be 
running. Could we have a  kernel-thread that can be run ASAP and does the 
native-mode thing, that can be killed if userspace runs an i18n demon?

HTH,

Ruth  


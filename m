Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267512AbUHPKbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267512AbUHPKbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUHPKbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:31:38 -0400
Received: from mail1.aster.pl ([212.76.33.23]:22676 "EHLO mail1.astercity.net")
	by vger.kernel.org with ESMTP id S267512AbUHPKbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:31:34 -0400
From: authn <opacki@acn.waw.pl>
Reply-To: opacki@acn.waw.pl
To: linux-kernel@vger.kernel.org
Subject: LKM, problem with simple char from string.
Date: Mon, 16 Aug 2004 12:31:51 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Organization: DsTool Lab
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161231.51998.opacki@acn.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am coding a linux kernel module and have problem with some string from user 
space (from execve system call). There is no problem with useing this string 
as a one, for example printk(KERN_ALERT "%s", string) works fine. 
Problem appears when i want to printk or compare single char, in first case it 
is printked with some extra '<1>' and in second case, when i compare it with 
other one, it doesnt fit to real char (it is "connected" with '<1>' in some 
way ?). I tried to copy it to kmalloced buffer:

if ((k_space=(char *)kmalloc(len, GFP_KERNEL))==NULL)
                        return -1;
memcpy_fromfs((void *)k_space, (void *)argv[argc], len); 

but then playing with k_space[i] was the same. 
Short code from module:
                if ((k_space=(char *)kmalloc(len, GFP_KERNEL))==NULL)
                        return -1;
                memset(k_space, '\0', sizeof(k_space));
                memcpy_fromfs((char *)k_space, (char *)argv[argc], len);
                printk(KERN_ALERT"%s\n", k_space);
                printk(KERN_ALERT "%c\n",k_space[i]);
And then i ll have in log file string (from first printk call) and char with 
<1> (from second printk call). It doesnt let me to compare chars.
What it happens ?


Regards, 
apacz

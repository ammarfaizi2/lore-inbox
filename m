Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVAKT4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVAKT4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVAKT4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:56:12 -0500
Received: from web50605.mail.yahoo.com ([206.190.38.92]:17082 "HELO
	web50605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261618AbVAKTzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:55:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=t+oxQ+gh4F52+1I43s2MvolnAIfF96OqtcfNTRzYmNx9eYCgM3jdTb19qnP9Gxu2lsrYoAHOQDumHRWcZiDnQqC8jeD/lz5KkJGEySCqWtc7ToljdVLlssSNMKkGSYAKqRMICxSfzCkJ/EE/W1OHK1Pzyz3lAKu1zWz322RqGVo=  ;
Message-ID: <20050111195542.76809.qmail@web50605.mail.yahoo.com>
Date: Tue, 11 Jan 2005 11:55:41 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Trusted Path Execution LSM 0.2 (20050108)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch leaks memory in the error paths. For example: 

+static ssize_t trustedlistadd_read_file(struct tpe_list *list, char *buf)
+{
<snip>
+ char *buffer = kmalloc(400, GFP_KERNEL);
+
+ user = (char *)__get_free_page(GFP_KERNEL);
+ if (!user)
+ return -ENOMEM;

There's several of these.

-Steve Grubb


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVAFDU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVAFDU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVAFDU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:20:59 -0500
Received: from [218.94.84.60] ([218.94.84.60]:11525 "EHLO
	mail.mobilesoft.com.cn") by vger.kernel.org with ESMTP
	id S262706AbVAFDUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:20:54 -0500
Subject: a little improvement  for vmalloc
From: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1104981532.628.10.camel@milo>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 Jan 2005 11:18:52 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In FUNCTION __vmalloc ,

There is a statement;

if (!size || (size >> PAGE_SHIFT) > num_physpages)
        return NULL;

I think the condition (num_phypages >>PAGE_SHIFT) > num_physpages 
is not very accurate. As we all know, linux kernel and other stuff
occupy some memory,so it is better to express like below, I think. 

if (!size || size > max_vmalloc_size)
	return NULL;

max_vmalloc_size = (num_physpages >> PAGE_SHIFT) - kernel_size          
                             -reserved_space_for_emergence_use


BTW, I would like to know whether there are reserved physical memory for
emergence use.

Thanks in advance!

Milo



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWHQUGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWHQUGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWHQUGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:06:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:28034 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030232AbWHQUGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:06:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nXbgCRHog5ssMEVuZgODOza6mTsYtAqvJGHD7UblQ/D9H6yfbP0SieXKjN0s+nVFM0+kk8rz187Fts0IpmqkRie0m5CEur/5Nt3AU3Ok4i/S9zo0r4VAEt3ZCbJi2Nwoe2UAufNc3mBPAu3ns7Pwt0pJbaVHId5iPIAPCOqXZQU=
Message-ID: <44E4CC60.3080109@gmail.com>
Date: Thu, 17 Aug 2006 14:06:56 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc4-mm1  Run-time of Locking API testsuite
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note the non-trivial execution time difference:

soekris:~/pinlab# egrep -e 'Locking|Good' dmesg-2.6.18-rc4-*
dmesg-2.6.18-rc4-mm1-sk:[   16.044699] | Locking API testsuite:
dmesg-2.6.18-rc4-mm1-sk:[   96.083576] Good, all 218 testcases passed! |
dmesg-2.6.18-rc4-sk:[   18.563808] | Locking API testsuite:
dmesg-2.6.18-rc4-sk:[   19.693692] Good, all 218 testcases passed! |



I diffed the respective configs, saw nothing obvious in the following,
some of them look like theyd favor -mm1, if anything.

<trimming the obvious irrelevants>

[jimc@harpo lxbuild]$ diff linux-2.6.18-rc4-sk/.config 
linux-2.6.18-rc4-mm1-sk/.config
3,4c3,4
< # Linux kernel version: 2.6.18-rc4
< # Mon Aug  7 17:53:01 2006
---
 > # Linux kernel version: 2.6.18-rc4-mm1
 > # Sun Aug 13 09:19:25 2006

1451a1491
 > CONFIG_ENABLE_MUST_CHECK=y
1454a1495
 > CONFIG_DEBUG_SHIRQ=y
1482,1483c1525,1528
< CONFIG_FORCED_INLINING=y
< CONFIG_RCU_TORTURE_TEST=y
---
 > # CONFIG_PROFILE_LIKELY is not set
 > # CONFIG_FORCED_INLINING is not set
 > # CONFIG_DEBUG_SYNCHRO_TEST is not set
 > # CONFIG_RCU_TORTURE_TEST is not set
1486c1531
< CONFIG_DEBUG_STACK_USAGE=y
---
 > # CONFIG_DEBUG_STACK_USAGE is not set


will send full configs if useful.

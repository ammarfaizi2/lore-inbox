Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUIPCHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUIPCHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUIPCHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:07:24 -0400
Received: from mail.renesas.com ([202.234.163.13]:20403 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S264953AbUIPCHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:07:16 -0400
Date: Thu, 16 Sep 2004 11:06:22 +0900 (JST)
Message-Id: <20040916.110622.640922499.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5 0/3] [m32r] Merge network drivers for m32r
 (was Re: 2.6.9-rc1-mm3)
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are patches to update network drivers for m32r.
These patches are against 2.6.9-rc1-mm5.
Pease apply them.

We removed m32r's locally modified network drivers and completely 
changed to use public drivers under drivers/net/.
Please give us any comments and suggestions.

Thank you.


Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.9-rc1-mm5 1/3] [m32r] Remove network drivers under 
arch/m32r/drivers/
  This patch removes local network drivers under arch/m32r/drivers/
  as follows:
     arch/m32r/drivers/8390.c
     arch/m32r/drivers/8390.h
     arch/m32r/drivers/smc91111.c
     arch/m32r/drivers/smc91111.copying
     arch/m32r/drivers/smc91111.h
     arch/m32r/drivers/smc91111.readme.txt
     arch/m32r/drivers/mappi_ne.c

  Instead of smc91111.c and mappi_ne.c, we use drivers/net/smc91x.c and
  drivers/net/ne.c, respectively.

  # Some other drivers are still remained in arch/m32r/drivers/, but
  # they are to be removed...

 arch/m32r/drivers/8390.c              |    1 
 arch/m32r/drivers/8390.h              |    1 
 arch/m32r/drivers/Kconfig             |    8 
 arch/m32r/drivers/Makefile            |    2 
 arch/m32r/drivers/mappi_ne.c          |  861 -------
 arch/m32r/drivers/smc91111.c          | 3894 ----------------------------------
 arch/m32r/drivers/smc91111.copying    |  352 ---
 arch/m32r/drivers/smc91111.h          |  570 ----
 arch/m32r/drivers/smc91111.readme.txt |  561 ----
 9 files changed, 6250 deletions(-)

--
[PATCH 2.6.9-rc1-mm5 2/3] [m32r] Modify drivers/net/smc91x.c for m32r
  This patch updates drivers/net/smc91x.c and merges m32r support to it.
  - Add m32r support.
  - Modify for SMP kernel.

 arch/m32r/kernel/io_mappi2.c      |   23 +++++++++++++----------
 arch/m32r/kernel/setup_m32700ut.c |   34 ++++++++++++++++++++++++++++++++--
 arch/m32r/kernel/setup_mappi2.c   |   34 ++++++++++++++++++++++++++++++++--
 arch/m32r/kernel/setup_opsput.c   |   34 ++++++++++++++++++++++++++++++++--
 drivers/net/Kconfig               |    2 +-
 drivers/net/smc91x.c              |   29 +++++++++++++++++++----------
 drivers/net/smc91x.h              |   13 +++++++++++++
 7 files changed, 142 insertions(+), 27 deletions(-)
  
--
[PATCH 2.6.9-rc1-mm5 3/3] [m32r] Modify drivers/net/ne.c for m32r
  This patch updates drivers/net/ne.c and merges m32r support to it.
  - Add m32r support.

 arch/m32r/kernel/setup_mappi.c   |    2 +-
 arch/m32r/kernel/setup_oaks32r.c |    2 +-
 drivers/net/8390.c               |   10 ++++++++++
 drivers/net/Kconfig              |    2 +-
 drivers/net/ne.c                 |   30 +++++++++++++++++++++++++++++-
 5 files changed, 42 insertions(+), 4 deletions(-)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

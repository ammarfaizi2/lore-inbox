Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVLNChi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVLNChi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVLNChi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:37:38 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:49824 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750987AbVLNChh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:37:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dJhaaZ+PZdFmAdlAMWL2M2gvFbBCQ5YdsoIaLGerXz9kCHeKwTvgLKz3nMq7dXYst5Quf3BpeM5PhmBgUvP+K/m+ztbuXVgLCJZ7+9JMCxrUBeH7+f0Q4wTWCcQiA6hKSFujwZS5bs3HVdTBOy9VDEuEwAqBwOJW4dIuNiJwARs=
Message-ID: <489ecd0c0512131837p654b7d8bqd63cd3342542d1da@mail.gmail.com>
Date: Wed, 14 Dec 2005 10:37:36 +0800
From: Luke Yang <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Two bugs in kernel 2.6.15-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   During porting Blackfin architecture to latest kernel, I found two issues:

 1. kernel/futex.c invokes handle_mm_fault() function, which calls
__handle_mm_fault(). But __handle_mm_fault() is defined in
mm/memory.c, which is only compiled when CONFIG_MMU is defined. So
those without MMUs can not use futex any more.

   How do you think this shall be fixed? Use #ifdef CONFIG_MMU ... #endif?

 2. In include/linux/module.h, "__crc_" and "__ksymtab_" are hard
coded to be the   prefix for some kinds of symbols (CRC symbol and
ksymtab section). But in script /mod/modpost.c,
MODULE_SYMBOL_PREFIX##"__crc_" is used as the prefix to search CRC
symbols. So if an architecture (such as h8300 or Blackfin) defines
MODULE_SYMBOL_PREFIX as not NULL ("_"), modpost will always warn about
"no invalid crc".

   I think we can just remove the MODULE_SYMBOL_PREFIX from  CRC_PFX
and  KSYMTAB_PFX in modpost.c. If you agree, I can send a patch for
this.

Best regards,
Luke Yang
Analog Device Inc.

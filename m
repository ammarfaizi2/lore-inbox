Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVGDO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVGDO7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVGDO7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:59:48 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43151 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261209AbVGDO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:59:44 -0400
Date: Mon, 4 Jul 2005 16:59:18 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Documentation mismatch in Documentation/kbuild/kconfig-language.txt
Message-ID: <Pine.LNX.4.58.0507041639500.24224@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Documentation/kbuild/kconfig-language.txt ---
- input prompt: "prompt" <prompt> ["if" <expr>]
  Every menu entry can have at most one prompt, which is used to display
  to the user. Optionally dependencies only for this prompt can be added
  with "if".
---

This is misleading, since the "if" will not affect only the prompt, but 
also the config option. 

Therefore I can't use
config SGI_IOC4
    tristate
    prompt "SGI IOC4 Base IO support" if PROMPT_FOR_UNUSED_CORES
    depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
    default n

to hide this option unless PROMPT_FOR_UNUSED_CORES is selected.

Since the "if" is useless, misleading and redundand with this behaviour, I 
suggest stripping it out.

-- 
Top 100 things you don't want the sysadmin to say:
43. The backup procedure works fine, but the restore is tricky!

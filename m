Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVIXRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVIXRdq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVIXRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:33:46 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:4803 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932203AbVIXRdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:33:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH][Fix] Prevent swsusp from corrupting page translation tables during resume on x86-64
Date: Sat, 24 Sep 2005 19:34:01 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241934.02455.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes Bug #4959.  It creates temporary page translation
tables located in the page frames that are not overwritten by swsusp while copying
the image.

The temporary page translation tables are generally based on the existing ones
with the exception that the mappings using 4KB pages are replaced with the
equivalent mappings that use 2MB pages only.  The temporary page tables are
only used for copying the image.

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>



-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

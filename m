Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265165AbUE0UE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbUE0UE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUE0UE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:04:26 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:56781 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265165AbUE0UEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:04:23 -0400
Date: Thu, 27 May 2004 21:03:20 +0100
From: Dave Jones <davej@redhat.com>
To: hpa@zytor.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: mem= handling mess.
Message-ID: <20040527200320.GR22630@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, hpa@zytor.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in time during 2.4, parse_cmdline_early() changed
so that it handled such boot command lines as..

mem=exactmap mem=640k@0 mem=511m@1m

And all was good.  This change propagated forward into 2.5,
where it sat for a while, until hpa freaked out and
Randy Dunlap sent in cset 1.889.364.25

ChangeSet 1.889.364.25 2003/03/16 23:22:16 akpm@digeo.com
  [PATCH] Fix mem= options
  
  Patch from "Randy.Dunlap" <rddunlap@osdl.org>
  
  Reverts the recent alteration of the format of the `mem=' option.  This is
  because `mem=' is interpreted by bootloaders and may not be freely changed.
  
  Instead, the new functionality to set specific memory region usages is
  provided via the new "memmap=" option.
  
  The documentation for memmap= is added, and the documentation for mem= is
  updated.

This is all well and good, but 2.4 never got the same treatment.
Result ? Now users are upgrading their 2.4 systems to 2.6,
and finding that they don't boot any more.
(See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=124312
 for example).

The "`mem=' is interpreted by bootloaders and may not be freely changed."
obviously hasn't broken the however many users of this we have in 2.4
so I don't buy that it'll break in 2.6 either.  As its now in 2.4
(and has been there for some time), this is something that bootloaders
will just have to live with.

		Dave


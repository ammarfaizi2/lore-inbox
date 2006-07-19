Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWGSJCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWGSJCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWGSJCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:02:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55735 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932535AbWGSJCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:02:15 -0400
Date: Wed, 19 Jul 2006 11:02:04 +0200
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060719090204.GA4980@suse.de>
References: <20060121180805.GA15761@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060121180805.GA15761@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 21, Olaf Hering wrote:

> 
> I want to add a gcc version check for reiserfs, on akpms request.

This debug patch still doesnt work in 2.6.18-rc2:


make -kj 14 O=$O

scripts/gcc-version.sh: line 11: _c_flags: command not found
scripts/gcc-version.sh: line 12: _c_flags: command not found
+ '[' 0000 -lt 0500 ']'
+ echo -O1


---
 fs/reiserfs/Makefile |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-rc2/fs/reiserfs/Makefile
===================================================================
--- linux-2.6.18-rc2.orig/fs/reiserfs/Makefile
+++ linux-2.6.18-rc2/fs/reiserfs/Makefile
@@ -30,6 +30,7 @@ endif
 ifeq ($(CONFIG_PPC32),y)
 EXTRA_CFLAGS := -O1
 endif
+EXTRA_CFLAGS += $(shell set -x ; if [ $(call cc-version) -lt 0500 ] ; then echo -O1 ; fi ;)
 
 TAGS:
 	etags *.c

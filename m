Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVDEJb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVDEJb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDEJbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:31:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261665AbVDEJaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:30:52 -0400
Date: Tue, 5 Apr 2005 10:30:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dave Airlie <airlied@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405093020.GA28620@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Dave Airlie <airlied@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org> <20050405074405.GE26208@infradead.org> <21d7e99705040502073dfa5e5@mail.gmail.com> <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, some more comments on the 32bit compat code in drm:

 - instead of set_fs & co and passing kernel addresses to drm_ioctl
   please use compat_alloc_user_space()

 - this:

+ifeq ($(CONFIG_COMPAT),y)
+drm-objs    += drm_ioc32.o
+radeon-objs += radeon_ioc32.o
+endif

   should be written as

drm-$(CONFIG_COMPAT)	+= drm_ioc32.o
radeon-$(CONFIG_COMPAT)	+= radeon_ioc32.o

   and everything else should use foo-y instead of foo-objs

 - the magic CONFIG_COMPAT changes for SHM handles should only be done when
   a module is set.  CONFIG_COMPAT is set for mostly 64bit systems that can
   run 32bit code and drm shouldn't behave differently just because we can
   run 32bit code.

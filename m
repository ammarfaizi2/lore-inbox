Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbUJZIc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUJZIc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUJZIc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:32:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:64722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262189AbUJZIcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:32:25 -0400
Date: Tue, 26 Oct 2004 01:30:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] make dnotify a configure-time option
Message-Id: <20041026013026.6b65bd24.akpm@osdl.org>
In-Reply-To: <1098767891.6034.50.camel@localhost>
References: <1098765164.6034.38.camel@localhost>
	<20041025214947.63031519.akpm@osdl.org>
	<1098767891.6034.50.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> wrote:
>
> make dnotify configurable, via CONFIG_DNOTIFY.

I don't think we want people accidentally disabling dnotify and making
kernels which don't implement the standard kernel API.  So...


diff -puN fs/Kconfig~make-dnotify-a-configure-time-option-embedded fs/Kconfig
--- 25/fs/Kconfig~make-dnotify-a-configure-time-option-embedded	2004-10-26 01:28:44.866957712 -0700
+++ 25-akpm/fs/Kconfig	2004-10-26 01:29:09.498213192 -0700
@@ -441,7 +441,7 @@ config QUOTACTL
 	default y
 
 config DNOTIFY
-	bool "Dnotify support"
+	bool "Dnotify support" if EMBEDDED
 	default y
 	help
 	  Dnotify is a directory-based per-fd file change notification system
_


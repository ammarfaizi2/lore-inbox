Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVBJNfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVBJNfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 08:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVBJNfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 08:35:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25218 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262118AbVBJNff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 08:35:35 -0500
Date: Thu, 10 Feb 2005 13:35:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050210133524.GA4544@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050210023508.3583cf87.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210023508.3583cf87.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 02:35:08AM -0800, Andrew Morton wrote:
> 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
> 
> 
> - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
>   It seems that nothing else is going to come along and this is completely
>   encapsulated.

Even if we accept a module that grants capabilities to groups this isn't fine
yet because it only supports two specific capabilities (and even those two in
different ways!) instead of adding generic support to bind capabilities to
groups.

More comments on the actual code:


+#include <linux/module.h>
+#include <linux/security.h>
+
+#define RT_LSM "Realtime LSM "		/* syslog module name prefix */
+#define RT_ERR "Realtime: "		/* syslog error message prefix */

+#include <linux/vermagic.h>
+MODULE_INFO(vermagic,VERMAGIC_STRING);

This doesn't belong into a module.

+#define MY_NAME __stringify(KBUILD_MODNAME)

Please use normal prefix.  A module shouldn't behave differently depending on
what name you compile it as.


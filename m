Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUDARvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbUDARv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:51:27 -0500
Received: from holomorphy.com ([207.189.100.168]:48302 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263010AbUDARvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:51:21 -0500
Date: Thu, 1 Apr 2004 09:51:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401175114.GH791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
	Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil> <20040401174405.GG791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401174405.GG791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 12:37:51PM -0500, Stephen Smalley wrote:
>> What prevents any uid 0 process from changing these sysctl settings
>> (aside from SELinux, if you happen to use it and configure the policy
>> accordingly)?

On Thu, Apr 01, 2004 at 09:44:05AM -0800, William Lee Irwin III wrote:
> I'm aware it does some very unintelligent things to the security model,
> e.g. anyone with fs-level access to these things can basically escalate
> their capabilities to "everything". Maybe some kind of big fat warning
> is in order.


Index: mm4-2.6.5-rc3/security/Kconfig
===================================================================
--- mm4-2.6.5-rc3.orig/security/Kconfig	2004-04-01 07:38:49.000000000 -0800
+++ mm4-2.6.5-rc3/security/Kconfig	2004-04-01 09:49:43.000000000 -0800
@@ -49,6 +49,13 @@
 	depends on SECURITY!=n
 	help
 	  This allows you to disable capabilities with sysctls.
+	  It effectively breaks the kernel's security model so that
+	  any user with fs-level access to /proc/sys/capability/*
+	  can escalate their privileges to "able to do anything",
+	  but some users have special-case needs for these things.
+	  Don't use this on any system with untrusted local users.
+	  It's probably best to firewall the living daylights out
+	  of anything using this also.
 
 source security/selinux/Kconfig
 

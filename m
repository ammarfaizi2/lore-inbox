Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVHIEBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVHIEBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVHIEBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:01:15 -0400
Received: from ozlabs.org ([203.10.76.45]:8635 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932436AbVHIEBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:01:14 -0400
Subject: Re: obsolete modparam change busted.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050808184955.GA18779@redhat.com>
References: <20050808184955.GA18779@redhat.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 14:01:16 +1000
Message-Id: <1123560076.13481.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 14:49 -0400, Dave Jones wrote:
> However this change was broken, and if the modprobe.conf
> has trailing whitespace, modules fail to load with the
> following helpful message..

Hi Dave,

	This fix should be preferable, I think.

Name: Ignore trailing whitespace on kernel parameters correctly
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Dave Jones says:

... if the modprobe.conf has trailing whitespace, modules fail to load
with the following helpful message..

	snd_intel8x0: Unknown parameter `'

--- linux-2.6.12/kernel/params.c	2005-07-15 04:39:53.000000000 +1000
+++ /tmp/foo.c	2005-08-09 13:56:04.000000000 +1000
@@ -1,0 +1,0 @@
@@ -135,11 +80,8 @@
 
 	DEBUGP("Parsing ARGS: %s\n", args);
 
-	while (*args) {
-		int ret;
-
-		args = next_arg(args, &param, &val);
-		ret = parse_one(param, val, params, num, unknown);
+	while (*(args = next_arg(args, &param, &val))) {
+		int ret = parse_one(param, val, params, num, unknown);
 		switch (ret) {
 		case -ENOENT:
 			printk(KERN_ERR "%s: Unknown parameter `%s'\n",

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman


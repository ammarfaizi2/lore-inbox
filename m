Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUCOB5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUCOB5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:57:11 -0500
Received: from main.gmane.org ([80.91.224.249]:17603 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261914AbUCOB5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:57:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.4-mm2
Date: Sun, 14 Mar 2004 17:57:21 -0800
Message-ID: <pan.2004.03.15.01.57.18.661707@triplehelix.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-222-152.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004 17:28:09 -0800, Andrew Morton wrote:
> +kbuild-fix-early-dependencies.patch
> +kbuild-fix-early-dependencies-fix.patch
> 
>  Parallel build fix

This set of patches requires the following fix to successfully link the
kernel:

--- linux/Makefile~   2004-03-14 17:52:54.000000000 -0800
+++ linux/Makefile    2004-03-14 17:52:21.000000000 -0800
@@ -988,7 +988,7 @@
        @set -e; \
        $(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
        $(cmd_$(1)); \
-       scripts/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
+       scripts/basic/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
        rm -f $(depfile); \
        mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)

-- 
Joshua Kwan



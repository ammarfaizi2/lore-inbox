Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVILXRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVILXRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVILXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:17:49 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:28108 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932351AbVILXRs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:17:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iPw5ucjRQhKssos40Z8ZQTab5yR26+JKu/Z4zB1kn8bFrBUnDvlPyjMStPzzWqOAvAk+5JHk6ZxwINDqNz2hBgWOmPTgPjA6xHOpUUF2OQ4amAzh0KBofzv5av9Ynn+yZl+k+AJ0hzmFGKKTHxUw/m+AZVfl/h36TF+buqwaT64=
Message-ID: <12c511ca050912161732e1e3d7@mail.gmail.com>
Date: Mon, 12 Sep 2005 16:17:43 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: tony.luck@gmail.com
To: sam@ravnborg.org
Subject: Re: new asm-offsets.h patch problems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509122102.j8CL2TW1021292@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509122102.j8CL2TW1021292@agluck-lia64.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a small delay to arch/ia64/Makefile (caution cut&pasted patch, will
be mangled) gets rid of the non-determinism. I tried "make prepare" 50
times, and all of them generated the asm-offsets.h file correctly.

Without the sleep the score was 9 successes to 21 failures in 30 trials.

-Tony

--- a/arch/ia64/Makefile       2005-09-12 16:02:41.000000000 -0700
+++ b/arch/ia64/Makefile  2005-09-12 15:54:31.000000000 -0700
@@ -88,6 +88,7 @@
        mkdir -p include/asm-ia64
        [ -s include/asm-ia64/asm-offsets.h ] \
        || echo "#define IA64_TASK_SIZE 0" > include/asm-ia64/asm-offsets.h
+       sleep 2
        touch $@

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVG0U3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVG0U3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVG0U2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:28:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24478
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262433AbVG0U1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:27:04 -0400
Date: Wed, 27 Jul 2005 13:27:01 -0700 (PDT)
Message-Id: <20050727.132701.115907512.davem@davemloft.net>
To: rml@novell.com
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       ttb@tentacle.dhs.org
Subject: Re: [patch] inotify: ppc64 syscalls.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122485496.21253.170.camel@betsy>
References: <1122479106.21253.158.camel@betsy>
	<20050727095539.602fcc4a.akpm@osdl.org>
	<1122485496.21253.170.camel@betsy>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Love <rml@novell.com>
Date: Wed, 27 Jul 2005 13:31:36 -0400

> [ I don't think we need sys32 compatibility versions--and if we do, I
> failed in life. ]

add_watch and rm_watch both do, because system call arguments are
zero-extended by default for compat tasks, thus the "fd" arg needs
sign extension.

You'll notice that sys_ppc32.c has a ton of shims which purely
exist to sign extend "int" system call arguments.  Sparc64 does
something similarly, but in assembler so that we don't eat the
overhead of a full stack frame just to sign extend arguments.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUDNI11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbUDNI11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:27:27 -0400
Received: from [66.35.79.110] ([66.35.79.110]:52941 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263969AbUDNI1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:27:25 -0400
Date: Wed, 14 Apr 2004 01:27:16 -0700
From: Tim Hockin <thockin@hockin.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-ID: <20040414082716.GA25439@hockin.org>
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407CF201.408@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat off the original topic, but am I the only one who finds it weird
(and error-prone) that you have to add the same KConfig to a dozen or more
Kconfig files?

Shouldn't there be a KConfig libe, and all you need to do for the arch is
reference the CONFIG_FOO from the lib?  Would at least save all the
duplicate strings and definitions...

Kconfig.lib:
	config DEBUG_BUFFERS
		bool "Enable additional filesystem buffer_head checks"
		depends on DEBUG_KERNEL
		help
		  If you say Y here, additional checks are performed that
		  aid filesystem development.

arch/*/Kconfig
	libpath /Kconfig.lib
	...
	insert DEBUG_BUFFERS
	...

If the inserted symbol is not found in the Kconfig libpath, error out.
You can then break debug Kconfigs into a separate lib file, etc.  Maybe
that's too far, but you get the idea?

Sorry, just a nit that bothers me.

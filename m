Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWEEWKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWEEWKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWEEWKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:10:36 -0400
Received: from ozlabs.org ([203.10.76.45]:23429 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751790AbWEEWKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:10:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
Date: Fri, 5 May 2006 16:03:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 04/13] cell: remove broken __setup_cpu_be function
In-Reply-To: <20060429233920.295209000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233920.295209000@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

>  From: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> This patch removes the incorrect Cell processor setup routine
> __setup_cpu_be.  This routine improperly accesses the hypervisor
> page size configuration at SPR HID6.  The correct behavior is for
> firmware, or if needed, platform setup code, to set the correct
> page size.

> -		.cpu_setup		= __setup_cpu_be,
> +		.cpu_setup		= __setup_cpu_power4,

That looks a bit dodgy.  Either just remove the contents of
__setup_cpu_be (leaving only the blr), or define a __setup_cpu_null
that does nothing, or make the identify_cpu not call the cpu setup
function if the pointer is NULL.

Paul.

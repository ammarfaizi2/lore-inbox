Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbULEBBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbULEBBH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbULEBBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:01:06 -0500
Received: from peabody.ximian.com ([130.57.169.10]:60556 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261216AbULEBAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:00:53 -0500
Subject: Re: [PATCH] aic7xxx large integer
From: Robert Love <rml@novell.com>
To: Miguel Angel Flores <maf@sombragris.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41B24542.7010803@sombragris.com>
References: <41B222BE.9020205@sombragris.com>
	 <41B24542.7010803@sombragris.com>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 20:02:06 -0500
Message-Id: <1102208526.6052.87.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 00:16 +0100, Miguel Angel Flores wrote:

> I post the patch very quickly :(. The original code finally seems OK. My 
> controller is not working with 39 bit addressing, although I can't find 
> why the compiler warns. Maybe the length of dma_addr_t type, in the 
> 2.6.9 the type of the mask_39bit variable is bus_addr_t.

The compiler warns because you are putting a 64-bit value (an unsigned
long long) in a 32-bit value (a u32).

There is definitely a problem on non-highmem compiled kernels, there is
no doubt of that.  The concern was that your suggested fix is not right.

Assuming that a 39-bit value is really wanted, the type either needs to
be changed to a dma64_addr_t or the value needs to change at
compile-time to a suitable 32-bit variant when !CONFIG_HIGHMEM64G.

Without knowing what the driver is doing, I have no idea.

	Robert Love



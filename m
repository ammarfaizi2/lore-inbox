Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUI2DG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUI2DG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 23:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUI2DG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 23:06:26 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:42817 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268165AbUI2DGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 23:06:24 -0400
Subject: RE: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
From: Paul Fulghum <paulkf@microgate.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF6375@orsmsx402.amr.corp.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF6375@orsmsx402.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1096427180.6003.49.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 28 Sep 2004 22:06:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:03, Feldman, Scott wrote:
> Maybe just
> the disable_irq call is all that is needed to solve the spurious
> interrupt case?

That would not work either.

request_irq() clears the enable/disable depth
only when registering the first device on that
interrupt.

If a device is sharing an interrupt with e100
and calls request_irq() before e100, then the
disable_irq() requires a matching enable_irq().

If e100 is the only or first device on
that interrupt, then the enable_irq() causes
the warning because the depth has been reset.

It is interesting behavior for request_irq.
I don't know if it was planned that way,
or is an unexpected artifact.
It makes the effect of the disable_irq call
indeterminate (to the driver) if made
before registering with the interrupt.

-- 
Paul Fulghum
paulkf@microgate.com



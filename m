Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbTF3Fyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 01:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTF3Fya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 01:54:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:55943 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S265771AbTF3FyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 01:54:24 -0400
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
From: David Woodhouse <dwmw2@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-mtd@lists.infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030629213450.B5653@flint.arm.linux.org.uk>
References: <20030623010031.E16537@flint.arm.linux.org.uk>
	 <1056544988.24294.9.camel@passion.cambridge.redhat.com>
	 <20030629213450.B5653@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat UK Ltd.
Message-Id: <1056953317.26374.22.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Mon, 30 Jun 2003 07:08:38 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: rmk@arm.linux.org.uk, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-29 at 21:34, Russell King wrote:
> > could you try v1.6 from CVS, which should refrain from pretending to have
> > ecc/oob access functions of none of the subdevices have them, and hence 
> > fix the problem you observed.
> 
> While looking over the changes between 1.5 and 1.6, I spotted this.  You
> may want to fix this change:
> 
> -                   concat->mtd.eccsize != subdev[i]->eccsize) {
> +                   concat->mtd.eccsize != subdev[i]->eccsize ||
> +                   !concat->mtd.read_ecc != !concat->mtd.read_ecc ||
> +                   !concat->mtd.write_ecc != !concat->mtd.write_ecc ||
> +                   !concat->mtd.read_oob != !concat->mtd.read_oob ||
> +                   !concat->mtd.write_oob != !concat->mtd.write_oob) {

Hmmm. That'll optimise well :) 

But it shouldn't bite you -- aside from that does it actually fix the
problem you'd observed?

-- 
dwmw2



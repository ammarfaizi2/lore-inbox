Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVBUJSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVBUJSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 04:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVBUJSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 04:18:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46607 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261928AbVBUJR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 04:17:58 -0500
Date: Mon, 21 Feb 2005 09:17:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Drohmann <m_droh01@uni-muenster.de>, linux-kernel@vger.kernel.org
Subject: Re: Why does printk helps PCMCIA card to initialise?
Message-ID: <20050221091754.A28213@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Drohmann <m_droh01@uni-muenster.de>,
	linux-kernel@vger.kernel.org
References: <42187819.5050808@uni-muenster.de> <20050220123817.A12696@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050220123817.A12696@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Feb 20, 2005 at 12:38:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 12:38:17PM +0000, Russell King wrote:
> The first thing that needs solving is why you're getting the "odd IO
> request" crap.  That may explain why the resource can't be allocated.

In cs.c, alloc_io_space(), find the line:

    if (*base & ~(align-1)) {

delete the ~ and rebuild.  This may resolve your problem.

This looks like a long standing bug in the PCMCIA code, going back to
2.4 kernels.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

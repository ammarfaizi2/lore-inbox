Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266583AbUF3IQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266583AbUF3IQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUF3IQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 04:16:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32524 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266583AbUF3IQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 04:16:25 -0400
Date: Wed, 30 Jun 2004 09:16:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630091621.A8576@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040630024434.GA25064@mail.shareable.org>; from jamie@shareable.org on Wed, Jun 30, 2004 at 03:44:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 03:44:34AM +0100, Jamie Lokier wrote:
> My question is: if the _kernel_ reads a PROT_NONE page, will it fault?
> It looks likely to me.

There are two different types of privileged accesses on ARM.  One is the
standard load/store instruction, which checks the permissions for the
current processor mode.  The other is one which simulates a user mode
access to the address.

We use the latter for get_user/put_user/copy_to_user/copy_from_user.

> This means that calling write() with a PROT_NONE region would succeed,
> wouldn't it?

No, because the uaccess.h function will fault, and we'll end up returning
-EFAULT.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

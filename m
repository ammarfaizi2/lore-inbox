Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWJLAHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWJLAHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWJLAHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 20:07:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:60301 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161307AbWJLAHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 20:07:32 -0400
Subject: Re: [PATCH 2.6.19-rc1] radeonfb: check return value of
	sysfs_create_bin_file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20061011235328.GA13264@dreamland.darkstar.lan>
References: <20061011235328.GA13264@dreamland.darkstar.lan>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 10:07:26 +1000
Message-Id: <1160611646.4792.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 01:53 +0200, Luca Tettamanti wrote:
> sysfs_create_bin_file() is marked as warn_unused_result but we don't
> actually check the return value.
> Error is not fatal, the driver can operate fine without the files so
> just print a notice on failure.

I find this whole business of must check return value for sysfs files to
be gratuitous bloat. There are many cases (like this one) where we don't
really care and a printk will just increase the kernel size for no good
reason.

Maybe we can have a macro we can use to silence the warning when we
don't care about the result ? Can gcc do that ?

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUCOGkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 01:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbUCOGkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 01:40:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:13276 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262428AbUCOGkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 01:40:45 -0500
Subject: Re: pmdisk suspend patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       swsusp-devel@lists.sourceforge.net
In-Reply-To: <c31t68$f99$1@sea.gmane.org>
References: <c31t68$f99$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1079332506.1966.152.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 17:35:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 02:19, Giridhar Pemmasani wrote:
> Hello
> 
> I have been trying to get a reliable way to suspend-to-disk. For me
> swsusp was taking more than a few minutes and swsusp2 was not
> reliable. So I decided to give pmdisk a chance. Since my laptop
> supported S4bios, pmdisk wouldn't let me change it to S4 platform
> based suspend. Even after fixing it, I didn't have much luck. I dug
> deeper and found another problem. pmdisk resumes all devices while
> suspending. So I patched the pmdisk to resume only the device on which
> suspend image is to be stored. With these patches, I have been able to
> use pmdisk reliably (tested with two laptops over 100 times).
> 
> I am not subscribed to the mailing list, so if you have problems or
> feedback, CC to me.

That's broken. You cannot call resume_device for a single device
like that. You must properly (and in order) resume the parents of
this device first. Your patch, on some controllers, will cause the
IDE layer to try to wake up the drive without waking up the IDE
controller itself.

I agree that it would be nice to be able to resume only one "branch"
of the PM tree like that, it's just not possible at this point.

Ben



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVCGXAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVCGXAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCGXAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:00:13 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55753 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261557AbVCGWYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:24:37 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: kexec and IRQ sharing
Date: Mon, 7 Mar 2005 14:24:18 -0800
User-Agent: KMail/1.7.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Randy Dunlap <rddunlap@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0503071555530.1789-100000@ida.rowland.org> <m1k6ojm7n2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6ojm7n2.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503071424.18645.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 March 2005 2:08 pm, Eric W. Biederman wrote:

> 
> The ongoing DMA transfers which are companions of the irq generating
> events are what really concern me, as we could get all kinds of
> interesting memory stomps.  Do you think you could implement
> a reboot notifier or a shutdown() method to handle that case?
> 
> This appears to be yet another case of kexec transforming theoretical
> bugs into actual ones.  Groan.

Reboot notifiers seem to be a more general solution than the
driver model shutdown() hooks, since as Alan noted not every
bus framework uses shutdown() ... and although remove() would
solve the issue too, for essentially all busses, it doesn't
kick in here (and linker tricks may have removed it anyway).

Of possible relevance:  Documentation/arm/Booting lists, at
the end, requirements the boot firmware must meet before it
runs Linux.  (Stuff like U-Boot, BLOB, HaRET, or dozens of
other open-sourced analogues of x86 BIOS code.)  Seems like
the same rules will apply before kexec ... yes?  That mentions
DMA, though not IRQs (possibly an omission).

- Dave


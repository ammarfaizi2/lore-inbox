Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFOHxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFOHxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:53:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:42762 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262000AbTFOHxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:53:13 -0400
Subject: Re: 2.5 and module loading
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: Per Bergqvist <per@synap.se>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030615070648.GA8576@triplehelix.org>
References: <200306150653.h5F6r3007462@tessla.levonline.com>
	 <20030615070648.GA8576@triplehelix.org>
Content-Type: text/plain
Message-Id: <1055664420.631.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jun 2003 10:07:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 09:06, Joshua Kwan wrote:
> On Sun, Jun 15, 2003 at 08:53:03AM +0300, Per Bergqvist wrote:
> > Can somebody please explain what is needed to get module loading
> > working with the 2.5.xx kernels ?
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/

For RedHat users, there's another pitfall in "/etc/rc.sysinit". During
startup, the script sets up the binary used to dynamically load modules
stored at "/proc/sys/kernel/modprobe". The initscript looks for
"/proc/ksyms" (if my memory servers me well), but since it doesn't exist
in 2.5 kernels, the binary used is "/sbin/true" instead.

This, eventually, will keep modules from working. RedHat users will have
to patch the "/etc/rc.sysinit" script to set "/proc/sys/kernel/modprobe"
to "/sbin/modprobe", even when "/proc/ksyms" doesn't exist.

I can't attach a patch. All my RH9 boxes are manually patched and can't
get access to the original "/etc/rc.sysinit" script :-(


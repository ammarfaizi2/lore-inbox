Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTDCXR3 (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263562AbTDCXR3 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:17:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21774 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262942AbTDCXR0 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 18:17:26 -0500
Date: Fri, 4 Apr 2003 00:28:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jes Sorensen <jes@wildopensource.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch 2.4] make tty->count atomic_t
Message-ID: <20030404002852.D18485@flint.arm.linux.org.uk>
Mail-Followup-To: Jes Sorensen <jes@wildopensource.com>,
	linux-kernel@vger.kernel.org, alan@redhat.com,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <16012.27749.781757.8312@trained-monkey.org> <20030404000608.B18485@flint.arm.linux.org.uk> <m3of3ndvb5.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3of3ndvb5.fsf@trained-monkey.org>; from jes@wildopensource.com on Thu, Apr 03, 2003 at 06:18:22PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 06:18:22PM -0500, Jes Sorensen wrote:
> >>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:
> Russell> On Thu, Apr 03, 2003 at 12:16:21PM -0500, Jes Sorensen wrote:
> >> I believe the 2.4 tty code is racey in the way it handles
> >> tty->count.  release_dev() does the tty->count-- thing without
> >> protecting against parallel execution, hence tty->count can end up
> >> a random state as
> tty-> count-- isn't guaranteed to be atomic (load-store architectures
> tty-> and
> >> architectures with weak memory ordering etc).
> 
> Russell> Isn't release_dev() only called under the BKL, which
> Russell> guarantees the old "single-thread in the kernel at a time"
> Russell> behaviour from pre-SMP Linux ?
> 
> It's called from tty_release() and tty_open(). tty_release() grabs the
> BKL but I don't see the path that grabs it when calling through
> tty_open() (doesn't mean I am not blind of course ;-).

It's hidden away in fs/devices.c:chrdev_open()

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


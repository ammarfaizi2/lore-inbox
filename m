Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVGLVIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVGLVIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGLVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:05:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33801 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262432AbVGLVD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:03:57 -0400
Date: Tue, 12 Jul 2005 22:03:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: serial_core: uart_open
Message-ID: <20050712220348.D11389@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	linux-kernel@vger.kernel.org
References: <02ad01c58710$ab9851c0$4b010059@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02ad01c58710$ab9851c0$4b010059@petzent.com>; from karl@petzent.com on Tue, Jul 12, 2005 at 11:36:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 11:36:51AM -0700, karl malbrain wrote:
> The uart_open code loops waiting for CD to be asserted (whenever CLOCAL 
> is not set).  The bottom of the loop contains the following code:
> 
> up(&state->sem);
> schedule();
> down(&state->sem);
> 
> if( signal_pending(current) )
>    break;

This does cause the process to sleep - in an interruptible wait.

Please give more details about the problem you're seeing.  Have you
tried getting a process listing from a different virtual console,
xterm or whatever you normally use?  What does that say?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWG0Rn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWG0Rn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWG0Rn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:43:27 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50698 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750810AbWG0Rn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:43:26 -0400
Date: Thu, 27 Jul 2006 18:43:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
Subject: Re: O_CAREFUL flag to disable open() side effects
Message-ID: <20060727174307.GC5178@flint.arm.linux.org.uk>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>,
	Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, akpm@osdl.org,
	viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com> <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI> <1154021616.13509.68.camel@localhost.localdomain> <44C8F8E3.1070306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C8F8E3.1070306@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 10:33:23AM -0700, H. Peter Anvin wrote:
> Dumb thought: would it make sense to add an O_CAREFUL flag to open(), to 
> disable side effects?  It seems that a number of devices have this issue 
> and one have to jump through weird hoops to configure them.  Obviously, 
> a file descriptor obtained with O_CAREFUL may not be fully functional, 
> at the device driver's option.
> 
> For a conventional file, directory, or block device O_CAREFUL is a 
> no-op.

What about door locking on block devices?  That might be an undesirable
side effect in some circumstances, so you might not want it to be a no-op
on blockdevs.

> For ttys it would typically behave similar to O_NONBLOCK 
> followed immediately by a fcntl to clear the nonblock flag.

What about, eg, raising DTR and RTS ?  You'd want to avoid raising
those if you're not actually going to be using the port.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSHZU2v>; Mon, 26 Aug 2002 16:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSHZU2v>; Mon, 26 Aug 2002 16:28:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49669 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318294AbSHZU2v>; Mon, 26 Aug 2002 16:28:51 -0400
Date: Mon, 26 Aug 2002 21:33:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy_to_user to a kmapped address
Message-ID: <20020826213304.I4763@flint.arm.linux.org.uk>
References: <200208262119.QAA03617@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208262119.QAA03617@ccure.karaya.com>; from jdike@karaya.com on Mon, Aug 26, 2002 at 04:19:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 04:19:37PM -0500, Jeff Dike wrote:
> Is this (in file_read_actor) bogus or am I missing something?
> 
> 1621            kaddr = kmap(page);
> 1622            left = __copy_to_user(desc->buf, kaddr + offset, size);
> 1623            kunmap(page);
> 
> It seems to me that copy_to_user should be able to assume that the destination
> address is a user address.
> 
> This is biting me because I'm moving the UML kernel into a separate address
> space, so there's no way, in general, to tell the difference between a kernel
> address and a userspace address.

Umm, that's copying from kaddr + offset _to_ desc->buf.  desc->buf
should be the user space address, and kaddr + offset a kernel address:

unsigned long __copy_to_user(void *to, const void *from, unsigned long n)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267675AbUBMTjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUBMTjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:39:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13842 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267235AbUBMTiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:38:19 -0500
Date: Fri, 13 Feb 2004 19:38:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shut up about the damn modules already...
Message-ID: <20040213193814.A8188@flint.arm.linux.org.uk>
Mail-Followup-To: Bas Mevissen <ml@basmevissen.nl>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040212031631.69CAD2C04B@lists.samba.org> <402D0083.7010606@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <402D0083.7010606@basmevissen.nl>; from ml@basmevissen.nl on Fri, Feb 13, 2004 at 05:51:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 05:51:15PM +0100, Bas Mevissen wrote:
> I'm wondering why it is that the kernel is asking for non-existing 
> modules so often. Is it that userspace applications try to access all 
> kinds of devices too often (autoprobing) or it this (wanted) kernel 
> behaviour?

Userspace probes the kernel to see if IPv6 is available by trying to
create an IPv6 socket.

The correct solution is to fix /etc/modprobe.conf such that it doesn't
try to load the module when you don't have it configured:

install net-pf-10 /bin/true

Note that if you alias net-pf-10 to ipv6 before this install line, you
need to replace net-pf-10 with ipv6 in the install line.

PS, I notice Arjan's RPM packages don't seem to contain the modprobe.conf
manual page... maybe this is what's causing some of the confusion?

PPS, It might also help to either mention in the man page that the
above corresponds to the original "alias modulename off" _or_ add
"install off /bin/true" into modprobe.conf.dist such that the old
alias line works as expected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

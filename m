Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTDONO6 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDONO5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:14:57 -0400
Received: from [195.82.120.238] ([195.82.120.238]:9615 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261362AbTDONO5 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 09:14:57 -0400
Date: Tue, 15 Apr 2003 14:24:58 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: M?ns Rullg?rd <mru@users.sourceforge.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Writing modules for 2.5
Message-ID: <20030415132458.GA15550@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	M?ns Rullg?rd <mru@users.sourceforge.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel> <p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide> <1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk> <yw1xbrz87x59.fsf@zaphod.guide> <20030415135758.C32468@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415135758.C32468@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 01:57:58PM +0100, Russell King wrote:
 > On Tue, Apr 15, 2003 at 02:39:14PM +0200, M?ns Rullg?rd wrote:
 > > My situation is like this: I am converting a char device driver to
 > > work with linux 2.5.  In the open and close functions there are
 > > MOD_INC/DEC_USECOUNT calls.  The question is what they should be
 > > replaced with.  Will it be handled correctly without them?
 > 
 > If it's a character device driver using the struct file_operations,
 > set the owner field as Alan mentioned, and remove the
 > MOD_{INC,DEC}_USE_COUNT macros from the open/close methods.  This
 > allows chrdev_open() (in fs/char_dev.c) to increment your module use
 > count automatically.

Unless the open/close functions are doing funky things (like the
watchdog drivers do).

		Dave


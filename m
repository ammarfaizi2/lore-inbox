Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUDJTIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUDJTII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:08:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9230 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261451AbUDJTIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:08:05 -0400
Date: Sat, 10 Apr 2004 20:08:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Force build error on undefined symbols
Message-ID: <20040410200802.E4221@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040410131028.A4221@flint.arm.linux.org.uk> <20040410142401.GA2439@mars.ravnborg.org> <20040410153519.C4221@flint.arm.linux.org.uk> <20040410172827.GA2106@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040410172827.GA2106@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Apr 10, 2004 at 07:28:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 07:28:27PM +0200, Sam Ravnborg wrote:
> How does output from your nm look?
> My version (GNU nm 2.14.90.0.5 20030722 (SuSE Linux)) looks like this:
> c04e56ac B zone_table
> 
> So I assume an undefined symbol would look like this:
> 00000000 U undef_symbol

No, because an undefined symbol does not have an address associated with
it.  So, it looks like this:

         U symbol

More than one blank space at the beginning, U, then one space and the
symbol.  On binutils built on 32-bit architectures, 9 spaces prefixing
the 'U'.  On 64-bit architectures, 17 spaces prefixing the 'U'.

(Yes, even a cross-built binutils building for a 32-bit architecture
on a 64-bit architecture gives you 64-bit addresses.)

Does the format _really_ matter this much?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

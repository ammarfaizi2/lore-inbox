Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTFPOTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTFPOTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:19:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13838 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263861AbTFPOTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:19:04 -0400
Date: Mon, 16 Jun 2003 15:32:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: mikpe@csd.uu.se, Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 cardbus problem + possible solution
Message-ID: <20030616153253.A13312@flint.arm.linux.org.uk>
Mail-Followup-To: mikpe@csd.uu.se, Dominik Brodowski <linux@brodo.de>,
	linux-kernel@vger.kernel.org
References: <16109.50492.555714.813028@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16109.50492.555714.813028@gargle.gargle.HOWL>; from mikpe@csd.uu.se on Mon, Jun 16, 2003 at 03:25:16PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 03:25:16PM +0200, mikpe@csd.uu.se wrote:
> 2.5.71 changed the name of the Yenta module from yenta_socket
> to yenta. In my case (Latitude with RH9 user-space), this
> prevented cardmgr from starting properly.
> 
> Quick fix: add 'alias yenta_socket yenta' to /etc/modprobe.conf,
> or s/yenta_socket/yenta/ in the appropriate config file (but
> then you make multi-booting 2.4/2.5 more difficult).

What do people want to do about this?  I have no particular desire to
answer all those emails asking about this, so unless Dominik objects,
I think we should just rename "yenta.c" to "yenta_socket.c" so we have
back-compatibility.

(This issue has appeared because yenta_socket.ko used to be created
by combining yenta.o with pci_socket.o.  Since pci_socket.c no longer
exists, we create the module from yenta.c directly, so its now called
yenta.ko.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTJZJyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTJZJyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:54:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9736 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263053AbTJZJyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:54:08 -0500
Date: Sun, 26 Oct 2003 09:54:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tovar <tvr@penngrove.fdns.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 better on VAIO R505EL and PowerMac 8500
Message-ID: <20031026095402.B25595@flint.arm.linux.org.uk>
Mail-Followup-To: Tovar <tvr@penngrove.fdns.net>,
	linux-kernel@vger.kernel.org
References: <E1ADhTk-0000hY-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1ADhTk-0000hY-00@penngrove.fdns.net>; from tvr@penngrove.fdns.net on Sun, Oct 26, 2003 at 01:46:32AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 01:46:32AM -0800, Tovar wrote:
>   'serial_cs' tries to free IO ports twice (still looking at that one).

This is mainly caused by the broken PCMCIA resource handling.  The
PCMCIA core still marks the resources it uses as busy.  This causes
some drivers to get a little upset when they try to do the same, and
when they and the PCMCIA core both try to release the resource.

Unfortunately, between all the PCMCIA bug fixing which went on earlier,
I didn't have time to sort out that aspect of PCMCIA.  I guess this
means that PCMCIA resource handling will remain broken for 2.6.

I've presently adopted a "lets see what happens to 2.6" strategy - I
have _zero_ idea what is going to be an acceptable level of change
once 2.6 is released.

This means that, for the time being, I'm ignoring everything apart
from simple and obvious bug fixes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

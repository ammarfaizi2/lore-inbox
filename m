Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUHSIsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUHSIsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUHSIsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:48:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263980AbUHSIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:47:06 -0400
Date: Thu, 19 Aug 2004 09:47:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM T22/APM suspend does not work with yenta_socket module loaded on 2.6.8.1
Message-ID: <20040819094702.A546@flint.arm.linux.org.uk>
Mail-Followup-To: Karel Gardas <kgardas@objectsecurity.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0408191011030.1006-100000@thinkpad.gardas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.43.0408191011030.1006-100000@thinkpad.gardas.net>; from kgardas@objectsecurity.com on Thu, Aug 19, 2004 at 10:16:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 10:16:04AM +0200, Karel Gardas wrote:
> I've found that APM suspend is not working on my IBM T22 properly, when
> cardbus services are loaded. I've identified the problematic piece of code
> as a yenta_socket module -- when I stop cardmgr and unload this module,
> suspend starts to work.

So it doesn't even work with cardmgr stopped and yenta loaded?
Have you tried removing any cards plugged in to the sockets?

You could try grabbing the cbdump program from pcmcia.arm.linux.org.uk
and trying to identify whether there's any differences in the register
settings of the Cardbus bridges - between having no yenta module loaded
and having yenta loaded with the sockets suspended using:

echo 3 > /sys/class/pcmcia_socket/pcmcia_socket0/device/power/state
echo 3 > /sys/class/pcmcia_socket/pcmcia_socket1/device/power/state

(echo 0 to these files to resume the sockets.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

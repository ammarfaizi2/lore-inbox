Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWBCCAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWBCCAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWBCCAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 21:00:31 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:19356 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S964843AbWBCCAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 21:00:30 -0500
Message-ID: <43E2B8D6.1070707@aarnet.edu.au>
Date: Fri, 03 Feb 2006 12:28:46 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australia's Academic & Research Network
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kumar Gala <galak@kernel.crashing.org>, rmk+kernel@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain>
In-Reply-To: <1138844838.5557.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -104.901 BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

The serial console driver has a host of issues

  - end of line should be CR LF, not LF CR

  - 'r' option for CTS/RTS flow control assumes CTS is
    asserted when DSR is not asserted. This is wrong as
    lots of modems float control lines when off.  No
    control signals are defined is DSR is unasserted.

  - [SECURITY] 'r' should require DCD to be asserted
    before outputing characters. Otherwise we talk to
    Hayes modem command mode.  This allows a non-root
    user to re-program the modem and is a major security
    issue is people configure calling line identification
    or encryption to restrict use of the serial console.

  - 'r' option has insanely slow CTS timeout. So if a
    terminal server is inactive the kernel can take
    30 minutes to boot as each character write to the
    serial console requires a CTS timeout.

All of these have been reported to me multiple times
(I'm maintainer of the Remote-Serial-Console-HOWTO).

I occassionally clean up and repost a patch I wrote years
ago which never gets integrated (although it ships in the
patchset of a number of kernels from supercomputer vendors).
I'm happy to clean it up again if there's a hope of
integration.

See
   <http://www.aarnet.edu.au/~gdt/patch/console/serial-console.patch>
for the most recent attempt.

Thanks so much,
Glen

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Australia's Academic & Research Network  www.aarnet.edu.au

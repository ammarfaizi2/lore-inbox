Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTLYJ5D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLYJ5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:57:02 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:19982 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264288AbTLYJ4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:56:52 -0500
Date: Thu, 25 Dec 2003 07:39:36 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: David Monro <davidm@amberdata.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: handling an oddball PS/2 keyboard
Message-ID: <20031225063936.GA15560@win.tue.nl>
References: <3FEA5044.5090106@amberdata.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEA5044.5090106@amberdata.demon.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 02:49:40AM +0000, David Monro wrote:

> I have a slightly odd PS/2 keyboard which I'm not quite sure of the best 
> way to handle. Its an NCD N-97, which shipped with some NCD X terminals 
> and also with some Mips workstations IIRC. Most of the keys produce the 
> normal scancodes, and most which don't can be fixed using setkeycodes. 
> However there are 2 keys which can't be made to work, which are F9 and 
> F10. The problem is that these produce raw scancodes 0x60 and 0x61, 
> which means the _release_ codes (setting the top bit) are 0xe0 and 0xe1.

Interesting. I rearranged my scancode data page a bit and added
your info - see http://www.win.tue.nl/~aeb/linux/kbd/scancodes-6.html
Are your scancodes identical to those reported by Benjamin Carter?

> So.. could I get a bunch of people to have a look in 
> /proc/bus/input/devices, and see what the 'Version' field for their 
> keyboard is? If it turns out that 0xab85 turns up on normal keyboards 
> then obviously I'll have to abandon the 2nd approach (or find another 
> way to ID it).

The overwhelming majority of all keyboards give 0xab83, translated to
0xab41, incorrectly back translated by the 2.6 kernel to 0xab02.

> What chance would either of these approaches have of getting merged?

Yours is the second report I see for ID 0xab85.
I have no information on the details of the other keyboard.
I suppose Vojtech will have no objections to using this ID
to skip the tests for e0 and e1 as protocol (escape) scancodes.
Either everybody is happy, or we learn a bit more about unusual keyboards.

Andries


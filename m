Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVLEW2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVLEW2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 17:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVLEW2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 17:28:30 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:28577 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964780AbVLEW2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 17:28:30 -0500
From: David Brownell <david-b@pacbell.net>
To: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH] [SPI] build as module and fix priority inversion problem
Date: Mon, 5 Dec 2005 14:24:50 -0800
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Vitaly Wool <vwool@ru.mvista.com>, stephen@streetfiresound.com
References: <20051205202605.92440.qmail@web36912.mail.mud.yahoo.com>
In-Reply-To: <20051205202605.92440.qmail@web36912.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051424.50408.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 12:26 pm, Mark Underwood wrote:
> Sorry, made a bit of a mess with the last e-mail :(. Trying again :) 
>  
> This patch fix's the possible priority inversion that vitaly pointed out

That part looks OK to me, though I don't have time to test it just.
It's the change to "use kmalloc if we must".

I'd like to see you split that part out so it can be merged into the
next MM kernel.  (I don't know when that is, but I'd guess RSN.)


> and allows the driver to be built as a module. 

That part won't work right.  Remember, the spi_board_info setup
must be safe to call from arch_init() code; that support needs
to be statically linked.  The full patch for this would split
those parts into a separate file, and expose some internal hooks
to the module.  (Like maybe the struct boardinfo type, and the
board_list of instances, and the lock protecting that list.)

- Dave

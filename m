Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbTDARpA>; Tue, 1 Apr 2003 12:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262704AbTDARpA>; Tue, 1 Apr 2003 12:45:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20616 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262701AbTDARo5>;
	Tue, 1 Apr 2003 12:44:57 -0500
Date: Tue, 01 Apr 2003 09:51:53 -0800 (PST)
Message-Id: <20030401.095153.92005641.davem@redhat.com>
To: shemminger@osdl.org
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66] sychronize_net patch (1/2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1049152378.2204.22.camel@dell_ss3.pdx.osdl.net>
References: <1049152378.2204.22.camel@dell_ss3.pdx.osdl.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: 31 Mar 2003 15:12:58 -0800

   @@ -2508,6 +2508,12 @@
    	return 0;
    }
    
   +/* Synchronize with packet receive processing. */
   +void synchronize_net() {
   +	br_write_lock_bh(BR_NETPROTO_LOCK);
   +	br_write_unlock_bh(BR_NETPROTO_LOCK);
   +}
   +

Functions without arguments are specified with "(void)" not "()", I'm
surprised the compiler didn't warn you about this.

Also, bad code style:

void function_name(args)
{
}

Never like:

void function_name(args) {
}

Functions are not braced like conditional statements such as:

	if (foo) {
	}

or

	while (foo) {
	}

Please fix this stuff.

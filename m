Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130021AbQK3ION>; Thu, 30 Nov 2000 03:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130569AbQK3IOD>; Thu, 30 Nov 2000 03:14:03 -0500
Received: from [216.161.55.93] ([216.161.55.93]:56561 "EHLO blue.int.wirex.com")
        by vger.kernel.org with ESMTP id <S130021AbQK3INx>;
        Thu, 30 Nov 2000 03:13:53 -0500
Date: Wed, 29 Nov 2000 23:44:20 -0800
From: Greg KH <greg@wirex.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyspan USB PDA adapter && test12pre3 hang
Message-ID: <20001129234420.A7196@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
        "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A25EB64.3462AE4D@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A25EB64.3462AE4D@haque.net>; from mhaque@haque.net on Thu, Nov 30, 2000 at 12:53:40AM -0500
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 12:53:40AM -0500, Mohammad A. Haque wrote:
> Anyone else out there with a Keyspan USB PDA adapter using test12-pre3?
> I'm experiencing hangs when I try to send data to my Palm Vx using it.
> Locks up the machine hard. No SysRq. No messages. USB serial debug
> output doesn't have much either...

Are you using the usb-uhci host driver?

If so, the following fix from Georg Acher should do the trick:

-----
Replace line 275 (insert_td())
qh->hw.qh.element = virt_to_bus (new) | UHCI_PTR_TERM;
by
qh->hw.qh.element = virt_to_bus (new) ;

-----

Let me (and the list) know if this doesn't fix your problem.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

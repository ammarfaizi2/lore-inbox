Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129182AbQKEJtV>; Sun, 5 Nov 2000 04:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129204AbQKEJtM>; Sun, 5 Nov 2000 04:49:12 -0500
Received: from Cantor.suse.de ([194.112.123.193]:31500 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129182AbQKEJsy>;
	Sun, 5 Nov 2000 04:48:54 -0500
Date: Sun, 5 Nov 2000 10:48:52 +0100
From: Andi Kleen <ak@suse.de>
To: David Feuer <David_Feuer@brown.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Select
Message-ID: <20001105104852.A25402@gruyere.muc.suse.de>
In-Reply-To: <4.3.2.7.2.20001105014402.00adee30@postoffice.brown.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20001105014402.00adee30@postoffice.brown.edu>; from David_Feuer@brown.edu on Sun, Nov 05, 2000 at 01:46:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 01:46:19AM -0500, David Feuer wrote:
> In the discussion on "select bug", some people noted that select does not 
> wake up a process until the buffer is half full (or all full, or 
> whatever).  Does this mean that if a small amount is written to the 
> device/pipe the process may never be woken?  Or is there a time limit that 
> wakes up the process after a certain amount of time if there are _any_ 
> bytes in the pipe/dev?

This only applies to POLLOUT. Yes, if an send buffer stays 90%
full forever you may be never woken up.

In case of a TCP socket you would be at worst waken up after considerable
time with a ETIMEDOUT. 

Pipes do not signal writable until the pipe is empty. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

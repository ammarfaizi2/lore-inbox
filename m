Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbULMO2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbULMO2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbULMO2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:28:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19616 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261219AbULMO2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:28:13 -0500
Date: Mon, 13 Dec 2004 09:56:40 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2.4] serial closing_wait and close_delay
Message-ID: <20041213115640.GI24597@logos.cnet>
References: <41ACC49A.20807@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ACC49A.20807@mev.co.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 07:06:02PM +0000, Ian Abbott wrote:
> Dear Marcelo,
> 
> This patch should fix various problems with the closing_wait and 
> close_delay serial parameters, but I can only test the standard serial 
> driver.
> 
> There are various scaling problems when HZ != 100:
> 
> * In several drivers, the values set by TIOCSSERIAL are scaled by 
> HZ/100, but the values got by TIOCGSERIAL are not scaled back.
> 
> * Invariably, the scaled closing_wait value is compared with an unscaled 
> constant ASYNC_CLOSING_WAIT_NONE or the same value by another name 
> (depending on the specific driver).
> 
> My patch stores the values set by TIOCSSERIAL without scaling and scales 
> the values by HZ/100 at the point of use.  (This is not as bad as it 
> sounds, as each value is scaled once per 'close'.)  There seems to be a 
> general consensus amongst the serial drivers that the closing_wait and 
> close_delay values from the user are in units of .01 seconds.

OK, it seems Russell's fix is simpler (and I'm not familiar with the code). 

I'll wait for that one to settle down.

> There is another problem, not related to HZ scaling:
> 
> * In several drivers, the closing_wait and close_delay values are 
> written to a struct serial_state by TIOCSSERIAL, but the values used in 
> the close routine are read from a struct async_struct, with no code to 
> transfer of values between the two structures.  My patch ignores the 
> members in struct async_struct and uses the values from struct serial_state.

Can you please split this part of the patch? (and send as a separate patch
to me CC Alan and Russell).

Thanks

> 
> -- Ian.
> 
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

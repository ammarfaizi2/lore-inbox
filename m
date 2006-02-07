Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWBGPMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWBGPMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWBGPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:12:13 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:38327 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S965117AbWBGPMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:12:13 -0500
In-Reply-To: <Pine.LNX.4.44.0602070848060.4804-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602070848060.4804-100000@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <473E72E7-9366-442A-95B7-F4A7CB15C04E@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 8250 serial console update uart_8250_port ier
Date: Tue, 7 Feb 2006 09:12:10 -0600
To: rmk+serial@arm.linux.org.uk
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

If you are ok with this can we make sure this gets to Linus for 2.6.16

thanks

- kumar

On Feb 7, 2006, at 8:52 AM, Kumar Gala wrote:

> On some embedded PowerPC (MPC834x) systems an extra byte would some  
> times be
> required to flush data out of the fifo. serial8250_console_write()  
> was updating
> the IER in hardware withouth also updating the copy in  
> uart_8250_port. This
> causes issues functions like serial8250_start_tx() and __stop_tx()  
> to misbehave.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> ---
> commit 0614711f0208f50e81d55283add8ae41bc332fc7
> tree 1da4194744b9ca1fe59976c6ebffccfee40299eb
> parent 45a38d42185df3e328e35e5167f2bfe181361db9
> author Kumar Gala <galak@kernel.crashing.org> Tue, 07 Feb 2006  
> 08:51:26 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Tue, 07 Feb 2006  
> 08:51:26 -0600
>
>  drivers/serial/8250.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 179c1f0..b1fc97d 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2229,6 +2229,7 @@ serial8250_console_write(struct console
>  	 *	and restore the IER
>  	 */
>  	wait_for_xmitr(up, BOTH_EMPTY);
> +	up->ier |= UART_IER_THRI;
>  	serial_out(up, UART_IER, ier | UART_IER_THRI);
>  }
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270173AbRHGK3p>; Tue, 7 Aug 2001 06:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRHGK3f>; Tue, 7 Aug 2001 06:29:35 -0400
Received: from customers.imt.ru ([212.16.0.33]:33342 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S270173AbRHGK3R>;
	Tue, 7 Aug 2001 06:29:17 -0400
Message-ID: <20010807032443.A10193@saw.sw.com.sg>
Date: Tue, 7 Aug 2001 03:24:43 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: root@chaos.analogic.com
Cc: Colin Walters <walters@cis.ohio-state.edu>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <873d75janh.church.of.emacs@space-ghost.verbum.org> <Pine.LNX.3.95.1010806144632.8686A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.3.95.1010806144632.8686A-100000@chaos.analogic.com>; from "Richard B. Johnson" on Mon, Aug 06, 2001 at 03:00:07PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 06, 2001 at 03:00:07PM -0400, Richard B. Johnson wrote:
[snip]
> This may not be a timing problem, but rather a problem that was
> attempted to be fixed with some timing change.
> 
> Possible problem (and solution). Given:
> 
> 	writel(value, pci_reg);
> 	status = readl(pci_reg);
> 
> The second readl() may (read will) complete before the writel().
> This is because writes to the PCI bus may be posted (queued). The
> first read will force all writes to complete, however the value
> read may be something that was not yet affected by the write.
> 
> 	writel(value, pci_reg);
> 	status = readl(pci_reg);
> 	status = readl(pci_reg);

Thanks for the note, I'll keep it in mind.

However, for this particular case I'm interested about a loop like
	while((a = readb(reg)) && --count >= 0);
I wonder if there are circumstances in which the repeated read's can return
"cached" values or whatever, so that the loop will result in significantly less
number of bus cycles than it's supposed?
My understanding is that there shouldn't be such.

Best regards
		Andrey

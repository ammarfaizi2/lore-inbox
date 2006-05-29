Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWE2ToX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWE2ToX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWE2ToX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:44:23 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:41647 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751250AbWE2ToX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:44:23 -0400
Date: Mon, 29 May 2006 21:43:35 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Frank Gevaerts <frank.gevaerts@fks.be>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060529194334.GA32440@fks.be>
References: <20060526182217.GA12687@fks.be> <20060526133410.9cfff805.zaitcev@redhat.com> <20060529120102.1bc28bf2@doriath.conectiva> <20060529132553.08b225ba@doriath.conectiva> <20060529141110.6d149e21@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529141110.6d149e21@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.813,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 02:11:10PM -0300, Luiz Fernando N. Capitulino wrote:
> 
>  Frank, could you try this one please?
> 
>  I have no sure whether this makes sense, but every USB-Serial driver
> I know exits in the write URB callback if the URB got an error.

It looks sane to me at least.
The machine is now running with this patch (and my ipaq_open patch, see
http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/1901.html).
If the problem is still there, it should occur within 24 hours in our
usage mode (25 ipaqs rebooting every 15 minutes to provide lots of
connects and disconnects).  I'll let you know the results.

Frank

> 
> -------------------
> 
> usbserial: ipaq: Don't handle URB on errors.
> 
> ipaq_write_bulk_callback() should exit if the URB got an error, otherwise
> we can get weird problems.
> 
> Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
> 
> ---
> 
>  drivers/usb/serial/ipaq.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 6ad106187344769a4722f9e6d6f265529844d568
> diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
> index 9a5c979..d263a5e 100644
> --- a/drivers/usb/serial/ipaq.c
> +++ b/drivers/usb/serial/ipaq.c
> @@ -855,6 +855,7 @@ static void ipaq_write_bulk_callback(str
>  	
>  	if (urb->status) {
>  		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
> +		return;
>  	}
>  
>  	spin_lock_irqsave(&write_list_lock, flags);
> -- 
> 1.3.2
> 
> 
> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

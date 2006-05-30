Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWE3IWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWE3IWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWE3IWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:22:15 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:53904 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932152AbWE3IWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:22:14 -0400
Date: Tue, 30 May 2006 10:21:41 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530082141.GA26517@fks.be>
References: <20060526182217.GA12687@fks.be> <20060526133410.9cfff805.zaitcev@redhat.com> <20060529120102.1bc28bf2@doriath.conectiva> <20060529132553.08b225ba@doriath.conectiva> <20060529141110.6d149e21@doriath.conectiva> <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva> <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529193330.3c51f3ba@home.brethil>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.814,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 07:33:30PM -0300, Luiz Fernando N. Capitulino wrote:
> On Mon, 29 May 2006 22:47:24 +0200
> Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> | 
> | The panic was caused by the read urb being submitten in ipaq_open,
> | regardless of success, and never killed in case of failure. What my
> | patch basically does is to submit the urb only after succesfully sending
> | the control message, and adding a sleep between tries. As long as this
> | patch is not applied, we hardly get any other error because the kernel
> | panics as soon as an ipaq reboots.
> 
>  I see.
> 
>  Did you try to just kill the read urb in the ipaq_open's error path?

Yes, that's what I did at first. It works, but with the long waits (we see
waits up to 80-90 seconds right now) I was afraid that the urb might timeout
before the control message succeeds.

Frank

> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

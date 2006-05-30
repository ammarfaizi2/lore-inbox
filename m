Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWE3PKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWE3PKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWE3PKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:10:17 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:60549 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932272AbWE3PKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:10:15 -0400
Date: Tue, 30 May 2006 17:09:43 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530150942.GC27700@fks.be>
References: <20060529120102.1bc28bf2@doriath.conectiva> <20060529132553.08b225ba@doriath.conectiva> <20060529141110.6d149e21@doriath.conectiva> <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva> <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530115329.30184aa0@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.815,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:53:29AM -0300, Luiz Fernando N. Capitulino wrote:
> On Tue, 30 May 2006 11:38:01 -0300
> "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> 
> | On Tue, 30 May 2006 10:21:41 +0200
> | Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> | 
> | | On Mon, May 29, 2006 at 07:33:30PM -0300, Luiz Fernando N. Capitulino wrote:
> | | > On Mon, 29 May 2006 22:47:24 +0200
> | | > Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> | | > | 
> | | > | The panic was caused by the read urb being submitten in ipaq_open,
> | | > | regardless of success, and never killed in case of failure. What my
> | | > | patch basically does is to submit the urb only after succesfully sending
> | | > | the control message, and adding a sleep between tries. As long as this
> | | > | patch is not applied, we hardly get any other error because the kernel
> | | > | panics as soon as an ipaq reboots.
> | | > 
> | | >  I see.
> | | > 
> | | >  Did you try to just kill the read urb in the ipaq_open's error path?
> | | 
> | | Yes, that's what I did at first. It works, but with the long waits (we see
> | | waits up to 80-90 seconds right now) I was afraid that the urb might timeout
> | | before the control message succeeds.
> | 
> |  Hmmm, I see.
> 
>  Thinking about this again, are you sure the read urb depends on the
> control message? It's quite easy to test, just a add a long timeout after
> the read URB was sent (say, five minutes) and waits for the read urb
> callback to run.
> 
>  If it ran _before_ the timeout expires with no timeout error it does not
> depend. Then we can do the simpler solution: just kill the read urb in the
> ipaq_open's error path.

I'll try it sometime today.

Frank

> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

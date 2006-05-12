Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWELLJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWELLJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWELLJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:09:55 -0400
Received: from soundwarez.org ([217.160.171.123]:36538 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751207AbWELLJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:09:54 -0400
Date: Fri, 12 May 2006 13:09:51 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Bill Nottingham <notting@redhat.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060512110951.GA4183@vrfy.org>
References: <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060313165719.GB4147@devserv.devel.redhat.com> <20060313192411.GA23380@vrfy.org> <20060313222644.GD1311@devserv.devel.redhat.com> <20060314152944.797390cd.vsu@altlinux.ru> <20060509174143.GA2320@ojjektum.uhulinux.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509174143.GA2320@ojjektum.uhulinux.hu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:41:44PM +0200, Pozsar Balazs wrote:

> Basically I implemented the above things, to be precise:
>  - the alias for the pnp device drivers are in the form "pnp:*dXXXYYYY*" 
>    instead of the old "pnp:dXXXYYYY*"
>  - the alias for the pnp card drivers are in the form
>      "pnp:cXXXYYYY*dXXXYYYY*dXXXYYYY*"
>    instead of the old
>      "pnp:cXXXYYYYdXXXYYYYdXXXYYYY*"
>    _and_ the device id part are ordered
>  - add a "modalias" file under sysfs for each pnp device, containing
>      "pnp:dXXXYYYYdXXXYYYY..."
>    where "dXXXYYYY" is appended for each pnp id the device has
>  - add a "modalias" file under sysfs for each pnp card, containing
>      "pnp:cXXXYYYYdXXXYYYYdXXXYYYY..."
>    where "cXXXYYYY" is the card_id, and the device ids are appended 
>    after it, _ordered_.
> 
> 
> With this applied, I think we are close to be able to drop 
> special-casing the pnp bus in udev rules.

That looks promising.

> What still needs to be done is exporting the MODALIAS env variable.
> (Sorry, I do not see how it could be added elegantly.)

Yeah, we really want the environment variable. You may do the composition
of the string in a separate function, that just writes to a bufferi, and use
it to fill the buffer of the uevent environment and the page of the sysfs
attribute. Like we did for input:
  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bd37e5a951ad2123d3f51f59c407b5242946b6ba


Thanks,
Kay

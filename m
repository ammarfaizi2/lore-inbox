Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbUCPQUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbUCPQJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:09:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:186 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263348AbUCPQGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:06:34 -0500
Message-ID: <405725F2.7090701@pobox.com>
Date: Tue, 16 Mar 2004 11:06:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [3C509] Fix sysfs leak.
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com>
In-Reply-To: <20040316134613.GA15600@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Mar 16, 2004 at 11:56:37AM +0100, Marc Zyngier wrote:
>  > >>>>> "davej" == davej  <davej@redhat.com> writes:
>  > 
>  > davej>  #ifdef CONFIG_EISA
>  > davej> -	if (eisa_driver_register (&el3_eisa_driver) < 0) {
>  > davej> +	if (eisa_driver_register (&el3_eisa_driver) <= 0) {
>  > davej>  		eisa_driver_unregister (&el3_eisa_driver);
>  > davej>  	}
>  > davej>  #endif
>  > 
>  > This is bogus. eisa_driver_register returns 0 when it *succeeds*.
> 
> Then the probing routine is bogus, it returns 0 when it fails too.

No, for the hotplug case the API allows registration to succeed, then 
probing calls the ->init_one function later.

	Jeff




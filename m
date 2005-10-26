Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVJZABy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVJZABy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVJZABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:01:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:60547 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932494AbVJZABx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:01:53 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <p733bmp40yz.fsf@verdi.suse.de>
References: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
	 <p733bmp40yz.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: IBM
Date: Tue, 25 Oct 2005 17:01:51 -0700
Message-Id: <1130284911.3586.152.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 01:43 +0200, Andi Kleen wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > Has anyone been bothered by the fact that notifier chains are not safe 
> > with regard to registration and unregistration while the chain is in use?
> > The notifier_chain_register and notifier_chain_unregister routines have 
> > writelock protections, but the corresponding readlock is never taken!
> 
> If you add locks to the reader make sure it is only taken
> if the list is non empty. Otherwise you will add unacceptable
> overhead to some fast paths.
>  
> Better would be likely to use RCU.

RCU will be a problem if the registered notifiers need to block.

> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



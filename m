Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTDIDgr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 23:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbTDIDgr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 23:36:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49071 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262690AbTDIDgq (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 23:36:46 -0400
Message-ID: <3E9397FC.8050000@pobox.com>
Date: Tue, 08 Apr 2003 23:48:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org,
       Kai Germaschewski <kai.germaschewski@gmx.de>, sfr@canb.auug.org.au,
       "Nemosoft Unv." <nemosoft@smcc.demon.nl>, davem@redhat.com
Subject: Re: SET_MODULE_OWNER?
References: <20030409032537.547E32C06F@lists.samba.org>
In-Reply-To: <20030409032537.547E32C06F@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3E937144.9090105@pobox.com> you write:
> 
>>Why don't you just let the maintainers apply the driver "cleanups" if 
>>they wish, or do not wish, like DaveM did.  Only when that is 
>>accomplished is it reasonable to consider moving SET_MODULE_OWNER -- and 
>>only then if other people do not need it's obvious utility.
> 
> 
> The please define when it should and should not be used, so everyone
> knows.

Use with structures that have an owner field, if you care about 
cross-version kernel source compatibility.


> Currently it seems to be:
> 
> /* This macro should be used on structures which had the owner field
>    added between 2.2 and 2.4, and not others. */
> 
> Is that correct?

No.  SET_MODULE_OWNER is useful regardless of kernel version, not just 
the restrictive set you define here.  Different vendors may implement 
SET_MODULE_OWNER with a different range of kernel versions, if they so 
choose. It's not restricted at all to when struct net_device gained an 
'owner' field.

Maybe think of it this way:  a source code hook whose implementation is 
free to change, as long as it functionally produces the desired result. 
    The in-kernel definition of the macro is only one of N implementations.

	Jeff




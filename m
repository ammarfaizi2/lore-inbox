Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263415AbTC2Nhy>; Sat, 29 Mar 2003 08:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbTC2Nhy>; Sat, 29 Mar 2003 08:37:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52623 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263415AbTC2Nhx>;
	Sat, 29 Mar 2003 08:37:53 -0500
Message-ID: <3E85A471.5000009@pobox.com>
Date: Sat, 29 Mar 2003 08:49:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: xircom init_etherdev conversion.
References: <200303241642.h2OGg335008252@deviant.impure.org.uk> <3E852901.7000903@pobox.com> <20030329110244.GA30863@suse.de>
In-Reply-To: <20030329110244.GA30863@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Mar 29, 2003 at 12:02:57AM -0500, Jeff Garzik wrote:
>  > davej@codemonkey.org.uk wrote:
>  > >- Also cleans up some exit paths.
>  > 
>  > ...and now xircom_remove is kfree'ing memory that was never kmalloc'd
> 
> Which one ? I don't see it..

"kfree(card)" here:

                 card=dev->priv;
...
                 kfree(card);
         }
         release_region(dev->base_addr, 128);
         unregister_netdev(dev);
         kfree(dev);
         leave("xircom_remove");



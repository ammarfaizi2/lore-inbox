Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTGFQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTGFQkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:40:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262584AbTGFQkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:40:13 -0400
Message-ID: <3F085448.6010503@pobox.com>
Date: Sun, 06 Jul 2003 12:54:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matthew Wilcox <willy@debian.org>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kobjects, sysfs and the driver model make my head hurt
References: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk> <20030706164626.GA17596@kroah.com>
In-Reply-To: <20030706164626.GA17596@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>(a)	kobj = kobject_get(kobj);
> 
> 
> This is the way to call kobject_get(), as the object we get after the
> function returns is the one we can then safely use.
[...]
> Think of it as, "now we can use this kobject, not the one before calling
> kobject_get()".


Doesn't matter.  There is still absolutely no reason for the additional 
pointer storage.  I agree with with you "Thinks of it as", but also add 
my own:  think of it as a spinlock function.  It doesn't return any 
value, but you can't touch the locked object(s) before you call the 
function.

The alloc functions return pointers.  The _get functions never need to, 
because logically there should always we at least one ref when we are 
calling _get.  (unless we want _get to notice an OBJ_FREEING flag and 
fail, that is...)

	Jeff




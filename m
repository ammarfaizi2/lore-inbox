Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTGFRAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTGFRAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:00:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5864 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262589AbTGFRAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:00:51 -0400
Message-ID: <3F085920.2040506@pobox.com>
Date: Sun, 06 Jul 2003 13:15:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Matthew Wilcox <willy@debian.org>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kobjects, sysfs and the driver model make my head hurt
References: <Mutt.LNX.4.44.0307070300180.930-100000@excalibur.intercode.com.au>
In-Reply-To: <Mutt.LNX.4.44.0307070300180.930-100000@excalibur.intercode.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Sun, 6 Jul 2003, Davide Libenzi wrote:
> 
> 
>>On Sun, 6 Jul 2003, Matthew Wilcox wrote:
>>
>>
>>>Why on earth does it return the value of its argument?
>>
>>Maybe for the same reason 'strcpy' returns 'dest'. It allows you to use
>>the function in a function parameter :
> 
> 
> It also makes calling code cleaner when copying refcounted objects:
> 
> e.g.
> 	new->foo = foo_get(old->foo);
> 	new->bar = bar_get(old->bar);
> 
> otherwise, you'd have to do:
> 
> 	foo_get(old->foo);
> 	new->foo = old->foo;
> 	bar_get(old->bar);
> 	new->bar = old->bar;

well...

	struct blah *foo_ref = foo;
	... not using foo_ref ...
	foo_get(foo_ref);
	... using foo_ref ...
	foo_put(foo_ref);

versus

	struct blah *foo_ref;
	... not using foo_ref ...
	foo_ref = foo_get(foo);
	... using foo_ref ...
	foo_put(foo_ref);

I suppose it's a matter of taste rather than necessity.

As a tangent, if kobject_get is so small now, why not just make it 
static inline to optimize this case?

	Jeff




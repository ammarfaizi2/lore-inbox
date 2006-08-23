Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWHWFfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWHWFfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 01:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWHWFfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 01:35:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27070 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751389AbWHWFfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 01:35:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LkEnNiiHLFV+mlMluapkG3lC6du2I5ITfLwgp/8vC0OE0g+FGGJzgiPGipCvr0Ecnn4XMT94yKgeVBCJGlE6KCImR0hoy7xVQttZ4kOsEI3AX2ffYm204g3hY6ekdXImF6C7Y6teGtPrk9BYwLOuv/4ChAZvzMYaYufwQ6j5IUQ=
Message-ID: <ec7cefb0608222235p155b7ab0ld8a23d2db1fbe56d@mail.gmail.com>
Date: Tue, 22 Aug 2006 22:35:14 -0700
From: "Eric Brower" <ebrower@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
In-Reply-To: <20060822.210136.59470258.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822.133901.110902970.davem@davemloft.net>
	 <200608222339.43511.dj@david-web.co.uk>
	 <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
	 <20060822.210136.59470258.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, David Miller <davem@davemloft.net> wrote:
> From: "Eric Brower" <ebrower@gmail.com>
> Date: Tue, 22 Aug 2006 20:59:14 -0700
>
> > The envctrl OOPS is definately my fault in the blind conversion of the
> > driver to the OF interface-- of_find_propery() return values should be
> > checked for NULL rather than relying upon a -1 value stored into lenp.
> >  We can discuss this separately, since you are using an out-of-kernel
> > driver.
>
> Ok.
>
> BTW, it is better to use "of_get_property()" if you are actually
> interested in the value since it will return a void pointer to the
> property value instead of a "struct property".  of_find_property() is
> useful if you just want to check for existence or if you want to
> modify the property value.
>

Thanks, Dave.  This driver is interested in property existence and
length-- some OBP versions don't create all expected envctrl
properties, and due to lack of implementation documentation the
property lengths are being checked as well; so of_find_property()
seems appropriate in this case.

Would you consider assigning -1 to lenp (if provided) in
of_find_property() when no matching device is found?

Thanks,
E

-- 
E

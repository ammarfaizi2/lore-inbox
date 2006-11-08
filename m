Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423847AbWKHWub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423847AbWKHWub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423853AbWKHWub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:50:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423847AbWKHWua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:50:30 -0500
Date: Wed, 8 Nov 2006 17:50:07 -0500
From: Dave Jones <davej@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gx-suspmod: fix "&& 0xff" typo
Message-ID: <20061108225007.GI3309@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20061108220435.GA4972@martell.zuzino.mipt.ru> <20061108141007.e0adf333.randy.dunlap@oracle.com> <20061108221626.GH3309@redhat.com> <20061108222046.GE4972@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108222046.GE4972@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 01:20:46AM +0300, Alexey Dobriyan wrote:
 > >  > > -	params->pci_rev = class_rev && 0xff;
 > >  > > +	params->pci_rev = class_rev & 0xff;
 > >  >
 > >  > Hi,
 > >  > any kind of automated detection on that one?
 > >
 > > grep -r "&& 0x" .  seems to be pretty effective modulo
 > > some false-positives.
 > 
 > Obligatory nit-picking:
 > 
 > 	grep '&&[ 	]*0[xX][fF]' -r .

That misses some cases. Like..

drivers/char/ipmi/ipmi_msghandler.c:                    bmc->id.device_revision && 0x80 >> 7);
drivers/char/ipmi/ipmi_msghandler.c:                    bmc->id.device_revision && 0x0F);

		Dave

-- 
http://www.codemonkey.org.uk

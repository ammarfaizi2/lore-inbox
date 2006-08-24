Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWHXQnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWHXQnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWHXQnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:43:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11985 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030377AbWHXQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:43:45 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <sergeh@us.ibm.com>
Cc: kjhall@us.ibm.com, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
In-Reply-To: <20060824152322.GD32764@sergelap.austin.ibm.com>
References: <1156359937.6720.66.camel@localhost.localdomain>
	 <20060823192733.GG28594@kvack.org>
	 <1156365357.6720.87.camel@localhost.localdomain>
	 <1156418815.3007.89.camel@localhost.localdomain>
	 <20060824133248.GC15680@sergelap.austin.ibm.com>
	 <1156428917.3007.150.camel@localhost.localdomain>
	 <20060824152322.GD32764@sergelap.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 18:05:13 +0100
Message-Id: <1156439113.3007.170.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 10:23 -0500, ysgrifennodd Serge E. Hallyn:
> Or will the page associated with the tty already have the data, and this
> really just needs to be fixed in the tty itself?

It is a matter of the timing and the device. You need to do revocation
at the device level because your security state change must occur after
the devices have all been dealt with. This is why I said you need the
core of revoke() to do this.

Patches like the one below are really trying to wallpaper over the
cracks in an implementation that doesn't work. The moment you replace
that part of the implementation with a proper revocation method that
waits for resources to be safe then it all works.

The security model is fine, the implementation is hitting the same
revocation feature wall as others.

> permission from a vma_area_struct.  This can be used, for example,
> by security modules wishing to revoke write permissions to a process
> whose clearance has changed.

What about drivers that use get_user_pages() - they have a locked kernel
mapping to the object but may not yet have accessed the data.

Plus the idea of a security indirect call every time we make a page
writable does not make me happy when considering performance. Not one
iota.

Alan


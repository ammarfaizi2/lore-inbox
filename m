Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbVCKCr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVCKCr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVCKCr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:47:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:21719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263350AbVCKCpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:45:51 -0500
Subject: Re: AGP bogosities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050311022332.GB20697@redhat.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <20050311021248.GA20697@redhat.com>
	 <16944.65532.632559.277927@cargo.ozlabs.ibm.com>
	 <20050311022332.GB20697@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 13:40:24 +1100
Message-Id: <1110508824.32556.320.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> After it does that pci_dev_put on the from, it does another pci_dev_get
> on 'dev', which is what my put was releasing.
> 
> Or am I terribly confused ?

Well, pci_get_class() put's the passed-in device and get's() the
returned one. So if you run it in a loop, you should never have to
either get or put. When you exit the loop with a valid pci_dev, though,
you should definitely put() it after you're done with it, but this is
something that should be done only for that specific instance and after
you are finished with it...

Ben.



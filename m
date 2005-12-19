Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVLSRqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVLSRqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVLSRqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:46:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8320 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932317AbVLSRqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:46:49 -0500
Subject: Re: [Bug] mlockall() not working properly in 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051219172735.GL13985@lug-owl.de>
References: <20051218212123.GC4029@mjk.myfqdn.de>
	 <20051219022108.307e68b8.akpm@osdl.org>
	 <20051219114231.GA2830@mjk.myfqdn.de>  <20051219172735.GL13985@lug-owl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Dec 2005 17:47:30 +0000
Message-Id: <1135014451.6051.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-19 at 18:27 +0100, Jan-Benedict Glaw wrote:
> > > that we did this because inheriting MCL_FUTURE is standards-incorrect.
> > 
> > Oh! So how can I make programs unswappable with kernel 2.6.x then?
> 
> That would mean that you cannot just exec() another program that will
> also be mlockall()ed. The new program has to do that on its own...

mlockall MCL_FUTURE applies to this image only and the 2.6 behaviour is
correct if less useful in some ways. It would be possible to add an
inheriting MCL_ flag that was Linux specific but then how do you control
the depth of inheritance ? If that isn't an issue it looks the easiest.

Another possibility would be pmlockall(pid, flag), but that looks even
more nasty if it races an exec.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVIPX35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVIPX35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIPX35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:29:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40421 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750764AbVIPX34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:29:56 -0400
Subject: Re: [linux-usb-devel] Re: Lost keyboard on Inspiron 8200 at 2.6.13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>, dtor_core@ameritech.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, caphrim007@gmail.com, david-b@pacbell.net,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20050916152432.5a05aeca.zaitcev@redhat.com>
References: <432A4A1F.3040308@gmail.com>
	 <200509152357.58921.dtor_core@ameritech.net>
	 <20050916025356.0d5189a6.akpm@osdl.org>
	 <d120d500050916082519c660e6@mail.gmail.com>
	 <1126886449.17038.4.camel@localhost.localdomain>
	 <20050916184440.GA11413@kroah.com>
	 <20050916152432.5a05aeca.zaitcev@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Sep 2005 00:54:51 +0100
Message-Id: <1126914891.17038.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-16 at 15:24 -0700, Pete Zaitcev wrote:
> I see why you would want to merge them, but is it worth the trouble?
> They are not identical. For one thing, early handoff installs its own
> fake interrupt handlers (Alan Cox insisted on it in the RHEL
> implementation).

You need them because an IRQ could be pending on the channel at the
point you switch over or triggered on the switch and a few people saw
this behaviour.

I'd like to see it shared but that means handoff belongs in the input
layer code and the USB layer needs to call into it if appropriate.


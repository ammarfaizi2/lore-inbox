Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVC0Mv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVC0Mv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 07:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVC0Mv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 07:51:26 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:8710 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261630AbVC0MvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 07:51:25 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
Date: Sun, 27 Mar 2005 15:51:18 +0300
User-Agent: KMail/1.5.4
Cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost> <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com> <1111913130.6297.24.camel@laptopd505.fenrus.org>
In-Reply-To: <1111913130.6297.24.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271551.18342.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's impossible to be otherwise. A call requires
> > that the return address be written to memory (the stack),
> > using register indirection (the stack-pointer).
> 
> and it's a so common pattern that it's optimized to death. Internally a
> call gets transformed to 2 uops or so, one is push eip, the other is the
> jmp (which gets then just absorbed by the "what is the next eip" logic,
> just as a "jmp"s are 0 cycles)

Arjan, you overlook the fact that kfree() contains 'if(!p) return;' too.
call + test-and-branch can never be faster than test+and+branch.
Maybe on the really clever CPU it can take the same time, but not faster...
--
vda


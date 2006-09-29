Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWI2JsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWI2JsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964770AbWI2JsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:48:19 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36996 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750921AbWI2JsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:48:17 -0400
Date: Fri, 29 Sep 2006 13:48:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andreas Jellinghaus <aj@ciphirelabs.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [ACRYPTO] New asynchronous crypto layer (acrypto) release.
Message-ID: <20060929094809.GA31117@2ka.mipt.ru>
References: <20060928120826.GA18063@2ka.mipt.ru> <451BCCDF.5000201@ciphirelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <451BCCDF.5000201@ciphirelabs.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 29 Sep 2006 13:48:13 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:23:43PM +0200, Andreas Jellinghaus (aj@ciphirelabs.com) wrote:
> Evgeniy Polyakov wrote:
> >Hello.
> >
> >I'm pleased to announce asynchronous crypto layer (acrypto) [1] release 
> >for 2.6.18 kernel tree. Acrypto allows to handle crypto requests 
> >asynchronously in hardware.
> >
> >Combined patchset includes:
> > * acrypto core
> > * IPsec ESP4 port to acrypto
> > * dm-crypt port to acrypto
> 
> so I should be able to replace a plain 2.6.18 kernel with one
> with this patchset and use dm-crypt'ed partitions (e.g. swap,
> encrypted root filesystem) as usual without further changes?
> 
> Did anyone test this with success?
> 
> Regards, Andreas

As I answered in your first e-mail, yes, you just need to patch 2.6.18
tree and load one of the crypto provider.

Acrypto works with request/response model, i.e. you ask acrypto core to
perform some operation on given buffers and if it can, it will call
your callback when it is ready (or some error happend and acrypto was
unable to reroute request to other device), otherwise it will return error.

With such a model it is possible to extend acrypto to any kind of
operations on buffers, not only crypto related, for example it is
possible to onload IPsec header transformation, perform DMA between
specified areas and much more.

-- 
	Evgeniy Polyakov

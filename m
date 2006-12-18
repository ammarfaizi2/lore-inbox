Return-Path: <linux-kernel-owner+w=401wt.eu-S1753974AbWLRNOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbWLRNOK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbWLRNOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:14:10 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55517 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbWLRNOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:14:08 -0500
Date: Mon, 18 Dec 2006 16:13:57 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andreas Jellinghaus <aj@ciphirelabs.com>
Cc: linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANN] Acrypto asynchronous crypto layer 2.6.19 release.
Message-ID: <20061218131356.GA11186@2ka.mipt.ru>
References: <20061216191521.GA26549@2ka.mipt.ru> <4586458E.6000503@dungeon.inka.de> <20061218095740.GA5219@2ka.mipt.ru> <458690EA.2000405@ciphirelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <458690EA.2000405@ciphirelabs.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 18 Dec 2006 16:13:59 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 02:00:26PM +0100, Andreas Jellinghaus (aj@ciphirelabs.com) wrote:
> Evgeniy Polyakov wrote:
> >Actually I do not recall what is 'size retrictions' - if you talk about
> >possibility to use software crypto provider, which supports one cipher
> >in a time, then yes, but it is intended to be used with hardware though.
> >Otherwise I do not recall any problems pointed to me.
> 
> sorry, "size restriction" was the wrong term. acrypto only supports
> "sync provider only supports AES-128 in CBC mode, so if you try
> different ciphers, there can be some problems."

You can change it in async_provider in compilation time or I can create
module version. There is an item in related todo list to use crypto
contexts, they were created exactly for such kind of things (actually
for hardware devices which do not support realtime key changes).

> and I'm using dm-crypto with aes-cbc-essiv:sha256 and your acrypto patch
> breaks this setup - not only acrypto doesn't provide crypto capability 
> for my setup, but with this patch it is not offered by the old mechanism
> either, so my system has no way to decrypt the root partition. note:
> that was with the 2.6.18 patch, no idea if it is different now.
> 
> so while the patch adds new features, it also removes some features -
> not sure if always (via patch) or via compile option or via module
> load. also I'm not sure if acrypto can be disabled via kernel command
> line to get the old behaviour (including aes-cbc-essiv:sha256 support
> for dm-crypt).
> 
> would be nice to track those issues, so people testing your patch
> are aware of the situation.

I will change acrypto software crypto provider, but right now, yes,
software crypto only supports one mode.

> Regards, Andreas

-- 
	Evgeniy Polyakov

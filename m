Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUIXXqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUIXXqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUIXXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:45:12 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:63908 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269092AbUIXXoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:44:22 -0400
Subject: Re: mlock(1)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrea Arcangeli <andrea@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040924225900.GY3309@dualathlon.random>
References: <41547C16.4070301@pobox.com>
	 <20040924132247.W1973@build.pdx.osdl.net>
	 <1096060045.10800.4.camel@localhost.localdomain>
	 <20040924225900.GY3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096069581.3591.23.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 09:46:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-09-25 at 08:59, Andrea Arcangeli wrote:
> On Fri, Sep 24, 2004 at 10:07:25PM +0100, Alan Cox wrote:
> > Keys are a different case anyway. We can swap them if we have encrypted
> > swap (hardware or software) and we could use the crypto lib just to
> > crypt some pages in swap although that might be complex. As such a
> > MAP_CRYPT seems better than mlock. If we don't have cryptable swap then
> > fine its mlock.
> 
> I really like encrypted swap, it should already work fine, I think we
> should make it the default. The cpu cost during swapping should be
> really not significant. It's needed anyways for running suspend on a
> laptop (currently suspend dumps into the swap the cleartext key of any
> cryptoloop device, making cryptoloop pretty much useless).  And the good
> thing is that it won't even need to ask for a password.

I plan on making a plugin for suspend2 that will use the cryptoapi to
encrypt the data. One of the problems with encrypting the swap partition
wholesale is that suspend implementations need to check whether the
image exists and get some unencrypted metadata before beginning to read
the image proper. Currently, they all store the location of the metadata
in the swap header. If that's encrypted, how will they know whether the
image exists. If we're working on an abstraction of swap (transparent
[en|de]cryption), will the actual header still be visible? Will it be
able to be set up early enough in the boot sequence for resuming? (That
later shouldn't be a problem for suspend2 as it lets you set things up
in an initrd before resuming).

Regards,

Nigel


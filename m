Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUIYJ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUIYJ3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269293AbUIYJ3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:29:30 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:35994 "EHLO
	mwinf0609.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269292AbUIYJ33 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:29:29 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Xavier Bestel <xavier.bestel@free.fr>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040925101937.A29796@flint.arm.linux.org.uk>
References: <Xine.LNX.4.44.0409241127220.7816-300000@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
	 <20040925013135.GJ9106@holomorphy.com>
	 <1096082711.7111.38.camel@at2.pipehead.org>
	 <20040925101937.A29796@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1096104467.2918.16.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 25 Sep 2004 11:27:49 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 25/09/2004 à 11:19, Russell King a écrit :

> I wonder if we should consider adding:
> 
> 	WARN_ON(!spin_is_locked(&tty_termios_lock));
> 
> in there.
> 
> However, the one annoying thing about "spin_is_locked" is that, on UP,
> it defaults to "unlocked" which makes these kinds of checks too noisy.
> Maybe we need a spin_is_locked() with a bias towards being locked for UP?

Or something like:

#define spin_is_safe(lock) ((!CONFIG_SMP) || spin_is_locked(lock))

(maybe as an inline)

	Xav


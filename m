Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUIYNVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUIYNVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUIYNVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:21:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18187 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269346AbUIYNUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:20:24 -0400
Date: Sat, 25 Sep 2004 14:20:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Paul Fulghum <paulkf@microgate.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040925142017.A3742@flint.arm.linux.org.uk>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	Paul Fulghum <paulkf@microgate.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Xine.LNX.4.44.0409241127220.7816-300000@thoron.boston.redhat.com> <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com> <20040925013135.GJ9106@holomorphy.com> <1096082711.7111.38.camel@at2.pipehead.org> <20040925101937.A29796@flint.arm.linux.org.uk> <1096104467.2918.16.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096104467.2918.16.camel@nomade>; from xavier.bestel@free.fr on Sat, Sep 25, 2004 at 11:27:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 11:27:49AM +0200, Xavier Bestel wrote:
> Le sam 25/09/2004 à 11:19, Russell King a écrit :
> 
> > I wonder if we should consider adding:
> > 
> > 	WARN_ON(!spin_is_locked(&tty_termios_lock));
> > 
> > in there.
> > 
> > However, the one annoying thing about "spin_is_locked" is that, on UP,
> > it defaults to "unlocked" which makes these kinds of checks too noisy.
> > Maybe we need a spin_is_locked() with a bias towards being locked for UP?
> 
> Or something like:
> 
> #define spin_is_safe(lock) ((!CONFIG_SMP) || spin_is_locked(lock))
> 
> (maybe as an inline)

You can't rely on CONFIG_SMP always being 0 or 1.  When it's turned off,
it's undefined, rather than being defined to 0.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

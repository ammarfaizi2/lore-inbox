Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbTCYBET>; Mon, 24 Mar 2003 20:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbTCYBET>; Mon, 24 Mar 2003 20:04:19 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:26117 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261308AbTCYBER>; Mon, 24 Mar 2003 20:04:17 -0500
Date: Tue, 25 Mar 2003 01:15:25 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       zwane@holomorphy.com
Subject: Re: [PATCH] module load notification try 2
Message-ID: <20030325011525.GA92370@compsoc.man.ac.uk>
References: <20030318155953.GA97463@compsoc.man.ac.uk> <20030325010738.10E762C05E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325010738.10E762C05E@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18xd2D-000JBv-00*vSqu.sm1a8.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 03:36:26PM +1100, Rusty Russell wrote:

> > +static inline int register_module_notifier(struct notifier_block * nb)
> > +{
> > +	return -ENOSYS;
> > +}
> 
> Shouldn't fail just because !CONFIG_MODULES: should just return 0.

Ho-de-hum, flipped a coin, lost the toss.

> Otherwise there's no way to sanely use them without wrapping in #ifdef

Well, "if (err && err != -ENOSYS)". The relative sanity of that is
debatable. I don't care either way, hence the coin toss.

I Cc:ed Zwane who was advocating -ENOSYS on IRC ...

> > +static DECLARE_MUTEX(notify_mutex);
> 
> Hmm, yes, you need to use your own protection around
> notifier_chain_register and notifier_call_chain.  Wierd, because
> notifier.c does its own locking for register and unregister, but not
> for calling, which AFAICT makes it useless...

I mentioned about this some time ago on lkml to massive indifference.
Later on someone from OSDL reworked all the notifier stuff, dunno what
happened to the patch.

regards,
john

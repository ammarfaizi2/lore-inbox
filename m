Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUIFDBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUIFDBV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUIFDBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:01:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:54507 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267405AbUIFC7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:59:20 -0400
Date: Sun, 5 Sep 2004 17:04:46 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Happe <andreashappe@flatline.ath.cx>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040906000446.GA16840@kroah.com>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901082819.GA2489@final-judgement.ath.cx>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:28:19AM +0200, Andreas Happe wrote:
> Hi,
> 
> following-up to: James Morris <jmorris@redhat.com> [040901 09:35]:
> >This looks potentially useful, although I'm not sure yet whether the 
> >userland crypto API should be exposed via sysfs or a separate filesystem.
> >
> >I suggest you post the patch to linux-kernel and the crypto API list at:
> >http://lists.logix.cz/pipermail/cryptoapi  as an RFC, for wider feedback.
> 
> the attached patch creates a /sys/cryptoapi/<cipher-name>/ hierarchie
> which includes all information which is currently offered by
> /proc/crypto. This was done by embedding a kobject in struct crypto_alg
> (include/linux/crypto.h) and using a kset/subsystem instead of the
> currently used list (crypto_alg->cra_list was removed, as it shouldn't
> be needed anymore). crypto/proc.c was converted to use the subsystem
> internal rwlock/list for its iteration of ciphers.
> 
> I think that the place for the cryptoapi-tree in sysfs is wrong (but the
> others (block, module, bus, class, etc.) seemed worse). But the effort
> to change this should be neglectable (and centered at syfs.c).

Why not use a class instead of a raw kobject?  Wouldn't a struct
class_device make things easier for you?  That would also put the stuff
into /sys/class/cryptoapi which I think makes a bit more sense than
/sys/cryptoapi.

Or how about just /sys/class/crypto ?

Other than that, I like this move, /proc/crypto isn't the best thing to
have in a proc filesystem :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276669AbRJPUQj>; Tue, 16 Oct 2001 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276670AbRJPUQ3>; Tue, 16 Oct 2001 16:16:29 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:37357 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S276669AbRJPUQS>; Tue, 16 Oct 2001 16:16:18 -0400
Date: Tue, 16 Oct 2001 22:16:45 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Cc: "Justin T . Gibbs" <gibbs@scsiguy.com>
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug
Message-ID: <20011016221645.A346@online.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Justin T . Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <20011015222311.E2665@turing> <200110152031.f9FKVlY56104@aslan.scsiguy.com> <20011016181726.E935@turing>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011016181726.E935@turing>
User-Agent: Mutt/1.3.22i
X-Operating-System: "debian SID Gnu/Linux 2.4.12 on i586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About the Oops, I think it's a hotplug problem but I could be wrong.

I get a Oops when I do the following :

. Insert my card (card detected and driver loaded)
. mount /dev/sdc0 /cdrw
. use /cdrw
. umount /cdrw
. Remove the card (remove event detected but driver not unloaded)
. mount /dev/sdc0 /cdrw (oops and mount segfault)

lspci show the adaptec card after insertion and no more after removing.

Actually the hotplug stuff doesn't unload the driver. This is not simple
because another card can use the driver. This is a new problem compared
to pcmcia stuff where you use a specific module.

My understanding is that the hotplug code should notify to the driver 
that a device managed by it has been removed. And the driver should
rescan for available devices.

I can send you the oops but I'm convinced that the Oops is caused by the
aic7xxx driver accessing a no more there device.

Is there a common way to ask to a driver to rescan it's devices (an
IOCTL). I'm afraid that not but it looks like a generic hotplug problem.

Christophe

On Tue, Oct 16, 2001 at 06:17:26PM +0200, christophe barbe wrote:
> I've patch my kernel with aic7xxx v6.2.4. The pci_table is correctly
> exported.
> I've a little problem (Oops) when I hot-remove the card and try to mount a
> device no more available. But I believe it's a hotplug issue so I will mail
> details to the hotplug ml.
> 
> Thank,
> Christophe
> 
> Le 2001.10.15 22:31:47 +0200, Justin T. Gibbs a écrit :
> > >I have defined __NO_VERSION__ before including module.h because in my
> > >understanding this is required when you include it in a multi-files
> > module.
> > >Only one file must include module.h without defining the __NO_VERSION__.
> > 
> > I can find no reference to "__NO_VERSION__" in module.h or the files
> > it includes.   Perhaps this is a requirement for old kernels?
> > 
> > >I remember to read something about a repository for your new driver.
> > Please
> > >could you point it to me and I will try it ASAP.
> > 
> > http://people.FreeBSD.org/~gibbs/linux/
> > 
> > --
> > Justin
> > 
> -- 
> Christophe Barbé <christophe.barbe@online.fr>
> GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Christophe Barbé <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291759AbSBXWvc>; Sun, 24 Feb 2002 17:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291762AbSBXWvZ>; Sun, 24 Feb 2002 17:51:25 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:26117 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291759AbSBXWvQ>; Sun, 24 Feb 2002 17:51:16 -0500
Date: Sun, 24 Feb 2002 23:51:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: vojtech@suse.cz, paulus@samba.org, hozer@drgw.net,
        dalecki@evision-ventures.com, torvalds@transmeta.com,
        andre@linuxdiskcert.org, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224235113.B2412@ucw.cz>
In-Reply-To: <20020224231002.B2199@ucw.cz> <15481.26697.420856.1109@argo.ozlabs.ibm.com> <20020224233937.B2257@ucw.cz> <20020224.144423.104049454.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224.144423.104049454.davem@redhat.com>; from davem@redhat.com on Sun, Feb 24, 2002 at 02:44:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 02:44:23PM -0800, David S. Miller wrote:

>    From: Vojtech Pavlik <vojtech@suse.cz>
>    Date: Sun, 24 Feb 2002 23:39:37 +0100
>    
>    > > happens if you plug in a 66MHz non-capable card to the 50 MHz bus.
>    > 
>    > The bus speed drops to 33MHz.
>    
>    Interesting. I'd expect 25 myself ... then we'll definitely need two
>    clock values in struct pci_bus - because the hi-speed one isn't always a
>    double the low one - as shown by your example.
> 
> You only need one, the current active one.
>
> If you think that hot-plug is an issue, the arch dependant could would
> need to recalculate the "current bus speed" and all would be fine.
> 
> So why do we need two values?

Oh, you're right. We indeed need only one.

Hmm, now hotplug changing the PCI clock would be quite a lot of fun -
all running drivers will need to know about the change, because some may
need to recompute the timings they have programmed into the chips ...

Because virtually disconnecting and reconnecting all the cards for which
the timings have changed will probably not be an option.

-- 
Vojtech Pavlik
SuSE Labs

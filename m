Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSBXXAW>; Sun, 24 Feb 2002 18:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291767AbSBXXAP>; Sun, 24 Feb 2002 18:00:15 -0500
Received: from altus.drgw.net ([209.234.73.40]:61701 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291766AbSBXXAA>;
	Sun, 24 Feb 2002 18:00:00 -0500
Date: Sun, 24 Feb 2002 16:59:37 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        dalecki@evision-ventures.com, torvalds@transmeta.com,
        andre@linuxdiskcert.org, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224165937.I1682@altus.drgw.net>
In-Reply-To: <20020224231002.B2199@ucw.cz> <15481.26697.420856.1109@argo.ozlabs.ibm.com> <20020224233937.B2257@ucw.cz> <20020224.144423.104049454.davem@redhat.com> <20020224235113.B2412@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224235113.B2412@ucw.cz>; from vojtech@suse.cz on Sun, Feb 24, 2002 at 11:51:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 11:51:13PM +0100, Vojtech Pavlik wrote:
> On Sun, Feb 24, 2002 at 02:44:23PM -0800, David S. Miller wrote:
> 
> >    From: Vojtech Pavlik <vojtech@suse.cz>
> >    Date: Sun, 24 Feb 2002 23:39:37 +0100
> >    
> >    > > happens if you plug in a 66MHz non-capable card to the 50 MHz bus.
> >    > 
> >    > The bus speed drops to 33MHz.
> >    
> >    Interesting. I'd expect 25 myself ... then we'll definitely need two
> >    clock values in struct pci_bus - because the hi-speed one isn't always a
> >    double the low one - as shown by your example.
> > 
> > You only need one, the current active one.
> >
> > If you think that hot-plug is an issue, the arch dependant could would
> > need to recalculate the "current bus speed" and all would be fine.
> > 
> > So why do we need two values?
> 
> Oh, you're right. We indeed need only one.
> 
> Hmm, now hotplug changing the PCI clock would be quite a lot of fun -
> all running drivers will need to know about the change, because some may
> need to recompute the timings they have programmed into the chips ...
> 
> Because virtually disconnecting and reconnecting all the cards for which
> the timings have changed will probably not be an option.

Personally, I think hot-plugging a 33mhz pci device into a 66mhz pci bus 
with other active devices on it is either user error or designer error 
(should have had a bridge), and a 'virtual disconnect and reconnect' is 
reasonable. 

You're going to kill (or at least stop) any transactions going on on the
bus while you're physically hot-plugging anway..

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWHREvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWHREvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 00:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWHREvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 00:51:32 -0400
Received: from 1wt.eu ([62.212.114.60]:22544 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932275AbWHREvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 00:51:31 -0400
Date: Fri, 18 Aug 2006 06:40:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Gerd v. Egidy" <gerd.von.egidy@intra2net.com>
Cc: Adrian Bunk <bunk@stusta.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       Andreas Steinmetz <ast@domdv.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060818044036.GA19344@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org> <20060817124839.GR7813@stusta.de> <20060817204307.GA17391@1wt.eu> <200608180141.20040.gerd.von.egidy@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608180141.20040.gerd.von.egidy@intra2net.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Fri, Aug 18, 2006 at 01:41:19AM +0200, Gerd v. Egidy wrote:
> Hi Willy,
> 
> first thank you for continuing work for 2.4, our company still relies on it 
> for a lot of machines.
> 
> > By this time, those people obviously know that they will have more
> > and more problems getting 2.4 to run reliably on fresh new hardware.
> 
> Yes, we've already experienced problems with new hw. We could solve most of 
> the stuff with some vendor supplied patches. But now we got performance 
> problems with ICH7 SATA performance: a disk does only about 11MB/s on 2.4 
> with all 2.4 patches from Jeff applied while we get about 40MB/s on 2.6.16. 
> Backporting the libata changes done between 2.6.15 (I think that is about the 
> same codebase as the current 2.4 stuff) and 2.6.16 seems like a big task.
> 
> So my question is: what is your policy on new or enhanced drivers (not just 
> new pciids)?

Generally, new drivers should be avoided. The main reason is very simple :
most of the kernel developers spend their time on 2.6. They know they don't
need to touch 2.4 much because what is in it does not change a lot.
Maintaining drivers takes a lot of time, needs a lot of testing and
feedback from the users. And of course, I don't have enough knowledge
to maintain all drivers myself ! So if a completely new driver which does
not overlap at all with anything else is proposed AND a maintainer swears
he's ready to support it for the whole 2.4 life, I might not be opposed
to merge it. But I will not ask current maintainers to support new drivers
in their areas.

In your case (SATA), you have a driver which is working, but performance
is not as good as on 2.6. Well, performance is a good reason to evaluate
2.6. Use 2.4 on the most critical machines, and 2.6 on those which can
suffer more common updates. Your feedback will help 2.6 developers a lot.
Of course, if you find real bugs in 2.4 SATA I'm OK to apply the fixes,
even more if the same fix is already in 2.6.

BTW, I have already looked at the 2.6 SATA code some time ago, and I
noticed that it has evolved very quickly since 2.4 got resynced. So
even if one would like to resync with current 2.6 code, I'm not sure
it would be easy at all. If you manage to provide a backport, we can
ask Jeff if agrees to merge it, but I'm not sure he will accept since
he said that current SATA in 2.4 was his last update.

BTW, another solution for you if you need performance on 2.4 might
be to try an add-on SATA controller of different brand. Those cards
are very cheap and will only use one PCI slot, which is OK if you
don't need it for anything else.

> Kind regards,
> 
> Gerd

Regards,
Willy


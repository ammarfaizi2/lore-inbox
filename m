Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVHaVXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVHaVXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVHaVXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:23:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24102
	"EHLO g5.random") by vger.kernel.org with ESMTP id S964968AbVHaVXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:23:13 -0400
Date: Wed, 31 Aug 2005 23:23:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050831212305.GU1614@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <1125412611.8276.9.camel@localhost.localdomain> <Pine.LNX.4.63.0508310033400.1930@cassini.linux4geeks.de> <1125444317.13646.6.camel@localhost.localdomain> <Pine.LNX.4.63.0508310117230.1930@cassini.linux4geeks.de> <1125495297.3355.24.camel@localhost.localdomain> <Pine.LNX.4.63.0508311623540.2012@cassini.linux4geeks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508311623540.2012@cassini.linux4geeks.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 04:28:59PM +0200, Sven Ladegast wrote:
> Why not generating a unique system ID at compilation stage of the kernel 
> if the apopriate kernel option is enabled? This needn't have something to 
> do with klive...just a unique kernel-ID or something like that.

I could also store an unique ID on disk without involving the kernel, if
all you want is to track a single computer. But I didn't want to track a
single computer. The main reason there is an "host" (as md5 of the IP)
is to give more values to info coming from different IP (assuming not
everyone is out there to confuse data). But it's not really about
tracking.

However I like the idea of uploading the `lspci -v` output since it
could be useful to know about really good hardware and drivers.

About the cookie I'm skeptical about the need of it, because it wouldn't
be secure anyway (there's no way for me to verify that the pci-ids are
the real ones that are in the computer so any notion of security is
quite pointless here), if something we need an ack that the packet was
not lost and that we should keep sending the pciids in at the next
packet too.

The only reason to use ssl would be to hide the pci-ids on the network
transfer (not really to make the cookie secure).

BTW, in the meantime I wrote the completely generic installer (this
is not rpm/deb kind of installer, it's a quick and dirty approach but it
should run in all distro and in all archs:

	wget http://klive.cpushare.com/install.sh
	sh install.sh --install

that will make it persistent. It goes into /var/tmp/klive-*

to uninstall it *completely*:

	sh install.sh --uninstall
	rm install.sh

You don't need root for the above (infact I never tested it as root, but
it should work as root too ;).

Please let me know if there are problem with the quick and dirty
installer (I finished it a few minutes ago), thanks!

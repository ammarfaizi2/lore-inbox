Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVKGTHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVKGTHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbVKGTHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:07:50 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:21186 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S965038AbVKGTHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:07:48 -0500
Date: Mon, 7 Nov 2005 20:07:38 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Greg KH <greg@kroah.com>
Cc: "Marco d'Itri" <md@Linux.IT>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051107190738.GC22737@ojjektum.uhulinux.hu>
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de> <20051106215158.GB3603@kroah.com> <20051107113329.GA7632@wonderland.linux.it> <20051107173157.GA16465@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107173157.GA16465@kroah.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:31:57AM -0800, Greg KH wrote:
> On Mon, Nov 07, 2005 at 12:33:29PM +0100, Marco d'Itri wrote:
> > On Nov 06, Greg KH <greg@kroah.com> wrote:
> > 
> > > This seems to be a Debian issue for some odd reason, I suggest filing a
> > > bug against the udev package (or just tagging onto the existing bug for
> > > this problem, I've seen it in there already...)
> > The reason this is usually seen only on Debian systems is that I am the
> > first one who shipped an udev package which runs many parallel modprobe
> > commands, but this is a genuine kernel/modprobe bug.
> 
> I'm pretty sure OpenSuSE 10.0 does the same thing, and I don't think
> anyone has reported the same kind of bugs there.  Makes me wonder what
> is really happening here...

If module A depends on module B, and "modprobe A" and "modprobe B" are 
run parallel, there is time window when module B is already listed in 
/proc/modules, but not completely loaded/initialized, it is in the state 
"Loading". At this point "modprobe A" checks /proc/modules if module B 
is already loaded, but it does not take into account that it is in the 
state "Loading" and not yet "Live". So it tries to load module A, but it 
fails, because there are missing symbols because module A did not 
register them yet.


-- 
pozsy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWEBWt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWEBWt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWEBWt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:49:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:40646 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965030AbWEBWtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:49:55 -0400
Date: Tue, 2 May 2006 15:48:09 -0700
From: Greg KH <greg@kroah.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       henne@nachtwindheim.de
Subject: Re: [ALSA] add __devinitdata to all pci_device_id
Message-ID: <20060502224809.GA30023@kroah.com>
References: <200605011511.k41FBUcu025025@hera.kernel.org> <1146502164.20760.53.camel@laptopd505.fenrus.org> <20060501165443.GA9441@kroah.com> <s5hmze0zrio.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hmze0zrio.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 11:48:31AM +0200, Takashi Iwai wrote:
> At Mon, 1 May 2006 09:54:43 -0700,
> Greg KH wrote:
> > 
> > On Mon, May 01, 2006 at 06:49:24PM +0200, Arjan van de Ven wrote:
> > > On Mon, 2006-05-01 at 15:11 +0000, Linux Kernel Mailing List wrote:
> > > > commit 396c9b928d5c24775846a161a8191dcc1ea4971f
> > > > tree 447f4b28c2dd8e0026b96025fb94dbc654d6cade
> > > > parent 71b2ccc3a2fd6c27e3cd9b4239670005978e94ce
> > > > author Henrik Kretzschmar <henne@nachtwindheim.de> Mon, 24 Apr 2006 15:59:04 +0200
> > > > committer Jaroslav Kysela <perex@suse.cz> Thu, 27 Apr 2006 21:10:34 +0200
> > > > 
> > > > [ALSA] add __devinitdata to all pci_device_id
> > > 
> > > 
> > > are you really really sure you want to do this?
> > > These structures are exported via sysfs for example, I would think this
> > > is quite the wrong thing to make go away silently...
> > 
> > I asked Henrik to not do this, but oh well...
> > 
> > No, if they are marked __devinit, and CONFIG_HOTPLUG is enabled, then
> > the sysfs stuff is enabled.  And since CONFIG_HOTPLUG is pretty much
> > always enabled these days, the savings of this kind of patch is
> > non-existant...
> 
> Then actually what could be a pitfall by adding __devinitdata to
> pci_device_id table?  If there is a potential danger, we should remove
> these modifiers from all places, especially from
> Documentation/pci.txt.

There's no real pitfall, only the chance for people to get it wrong
(using __initdata instead, or using __devinitdata for hotplug-only
drivers.)

thanks,

greg k-h

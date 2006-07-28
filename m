Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWG1KrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWG1KrU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWG1KrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:47:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:49397 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932628AbWG1KrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:47:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TcUSy+5L16V/EoC3rE1Sefv29m2mICJtBlWc1fFHCxfu1BL6ReQDGRijV0NXPe1NxDeAAKi+V9noa78s7WFXgRfxjWFEa8CBhqULdjooUa+tMdeN8WZc4mPSmhjN7xADj3e0WBg5452UKkBSnKS/tzxoapT9GFNuAfrSbT9bC88=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Sound problems with snd_hda on x86_64
Date: Fri, 28 Jul 2006 12:47:11 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, PeiSen Hou <pshou@realtek.com.tw>,
       linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
References: <200607281216.25214.vda.linux@googlemail.com> <s5hr706nhtr.wl%tiwai@suse.de>
In-Reply-To: <s5hr706nhtr.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281247.11986.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 12:29, Takashi Iwai wrote:
> > Which is, in turn, is caused by this code:
> > 
> > --- linux-2.6.17.6.org/sound/core/pcm_compat.c	2006-07-15 21:00:43.000000000 +0200
> > +++ linux-2.6.17.6.src/sound/core/pcm_compat.c	2006-07-28 00:35:10.000000000 +0200
> > @@ -478,6 +478,8 @@ static long snd_pcm_ioctl_compat(struct 
> >  	 * mmap of PCM status/control records because of the size
> >  	 * incompatibility.
> >  	 */
> > +printk("substream->no_mmap_ctrl = 1 in %s:%s line %d\n", __FILE__, __FUNCTION__, __LINE__);
> > +dump_stack();
> >  	substream->no_mmap_ctrl = 1;
> >  
> >  	switch (cmd) {
> > 
> > It's puzzling. Even a 486 processor, can do 64-bit operations (using cmpxchg8)
> > on memory-mapped areas, why does code disallows mmap for 64-bit CPUs but allows
> > for 32-bit ones?
> 
> On the contrary, the driver disallows mmap for 32bit task on 64bit
> architecture.  This is because the size of the mapped record is
> different between 32bit and 64bit architectures, so it cannot be
> shared.

Why artsd attempts mmap at all then? Why it thinks that
/dev/snd/pcmC0D0p is mmap-able when it is not?

> BTW, with the recent version of alsa-lib, you no longer need artsd
> unless you want a network transparent.  Disable it on kde control
> center.

This is good.
--
vda

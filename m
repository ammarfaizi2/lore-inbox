Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWE3LDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWE3LDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWE3LC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:02:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:8866 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932260AbWE3LCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:02:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qsoiSgu+WWCdJOonVVmXCsgdF1sIjO69Gey6/e0lI/YvoJa4iB9DX8+jjugklr8USJohsUJO4CV3ZdGPBtGbty3nvHsE3z3hmfRjyCmdzO7r803f7pD6ewTunBUJmmpnMKFFsvl69PZfYUWGIUAIkS7/nIdC72u7bweIZ//JvnE=
Date: Tue, 30 May 2006 15:03:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: [patch 03/61] lock validator: sound/oss/emu10k1/midi.c cleanup
Message-ID: <20060530110314.GB31189@martell.zuzino.mipt.ru>
References: <20060529212109.GA2058@elte.hu> <20060529212319.GC3155@elte.hu> <20060529183317.0101f28d.akpm@osdl.org> <s5h64jndbue.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h64jndbue.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:51:53PM +0200, Takashi Iwai wrote:
> At Mon, 29 May 2006 18:33:17 -0700,
> Andrew Morton wrote:
> > 
> > On Mon, 29 May 2006 23:23:19 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > move the __attribute outside of the DEFINE_SPINLOCK() section.
> > > 
> > > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > > ---
> > >  sound/oss/emu10k1/midi.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: linux/sound/oss/emu10k1/midi.c
> > > ===================================================================
> > > --- linux.orig/sound/oss/emu10k1/midi.c
> > > +++ linux/sound/oss/emu10k1/midi.c
> > > @@ -45,7 +45,7 @@
> > >  #include "../sound_config.h"
> > >  #endif
> > >  
> > > -static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
> > > +static __attribute((unused)) DEFINE_SPINLOCK(midi_spinlock);
> > >  
> > >  static void init_midi_hdr(struct midi_hdr *midihdr)
> > >  {
> > 
> > I'll tag this as for-mainline-via-alsa.
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> It's OSS stuff, so feel free to push it from your side ;)

Why it is marked unused when in fact it's used?

[PATCH] Mark midi_spinlock as used

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- a/sound/oss/emu10k1/midi.c
+++ b/sound/oss/emu10k1/midi.c
@@ -45,7 +45,7 @@
 #include "../sound_config.h"
 #endif
 
-static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
+static DEFINE_SPINLOCK(midi_spinlock);
 
 static void init_midi_hdr(struct midi_hdr *midihdr)
 {


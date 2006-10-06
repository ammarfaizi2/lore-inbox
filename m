Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWJFLqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWJFLqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWJFLqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:46:55 -0400
Received: from gate.perex.cz ([85.132.177.35]:23515 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932162AbWJFLqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:46:54 -0400
Date: Fri, 6 Oct 2006 13:46:52 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>
Subject: Re: [Alsa-devel] [PATCH] Driver core: Don't ignore error returns
 from probing
In-Reply-To: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.61.0610061338230.8573@tm8103.perex-int.cz>
References: <20061005175852.GC15180@suse.de>
 <Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
 <20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
 <Pine.LNX.4.61.0610061138580.8573@tm8103.perex-int.cz>
 <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Cornelia Huck wrote:

> On Fri, 6 Oct 2006 11:41:05 +0200 (CEST),
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > Hm, I don't think we should call device_release_driver if
> > > bus_attach_device failed (and I think calling bus_remove_device if
> > > bus_attach_device failed is unintuitive). I did a patch that added a
> > > function which undid just the things bus_add_device did (here:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115816560424389&w=2),
> > > which unfortunately got lost somewhere... (I'll rebase and resend.)
> > 
> > Yes, but it might be better to check dev->is_registered flag in 
> > bus_remove_device() before device_release_driver() call to save some code, 
> > rather than reuse most of code in bus_delete_device().
> 
> If we undid things (symlinks et al.) in the order we added them, we can
> factor out bus_delete_device() from bus_remove_device() and avoid both
> code duplication and calling bus_remove_device() if bus_attach_device()
> failed. Something like the patch below (untested).

It looks better, but I think that having only one function with if 
(is_registered) saves a few bytes of instruction memory. Anyway, I do not 
feel myself to judge what's the best.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbULTQzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbULTQzl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULTQzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:55:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:8872 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261568AbULTQzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:55:35 -0500
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hr7lluei7.wl@alsa2.suse.de>
References: <1103389648.5967.7.camel@gaston>
	 <1103391238.5775.0.camel@gaston>  <s5hr7lluei7.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 17:55:17 +0100
Message-Id: <1103561717.5301.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 17:21 +0100, Takashi Iwai wrote:

> Well, the volume and PCM shouldn't be racy.  I'd first suspect another
> bug in PCM OSS emulation code...
> 
> Could you compile with CONFIG_SND_DEBUG=y and see whether it catches
> anything?

Didn't catch anything. However, I reproduced it a bit differently this
time, it didn't try to jump into a NULL pointer in the rate "plugin",
but rather went into resample and died there on a data access exception
to some corrupt pointer.

I don't have a 100% reprocase yet, it seem to be related to playing with
an OSS mixer while using an OSS app (like xmms), that is basically
having 2 things opening the OSS emulation, and one of them closing it,
or something like that, causing the rate plugin (and maybe more) to be
tore down, while still in use by the other app (looks like a
use-after-free).

Ben.



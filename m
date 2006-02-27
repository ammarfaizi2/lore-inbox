Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWB0HKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWB0HKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWB0HKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:10:47 -0500
Received: from styx.suse.cz ([82.119.242.94]:17824 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751584AbWB0HKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:10:46 -0500
Date: Mon, 27 Feb 2006 08:11:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060227071107.GA8201@suse.cz>
References: <20060220132832.GF4971@stusta.de> <Pine.LNX.4.61.0602252300200.7535@yvahk01.tjqt.qr> <20060225220737.GE3674@stusta.de> <200602251723.53349.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602251723.53349.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 05:23:52PM -0500, Dmitry Torokhov wrote:
 
> Adrian,
> 
> There are requests to move it out of EMBEDDED because sometimes you
> just  don't need input layer at all. Dave Jones mentioned that he
> feels silly enabling EMBEDDED on iSeries... I am thinking about
> changing it to "EMBEDDED || !X86_PC" to safe-guard the most common
> platform from accidenially disabling it.
> 
> I am still not convinced whether INPUT=m makes sence, especially if
> we make ACPI use input layer... Jan's example about input device with
> hot-pluggable keyboard is a bit of a stretch. 
 
The possibility to keep INPUT=m makes a big sense in that it keeps the
interfaces to the rest of the kernel clean. No direct linking, no
callbacks into inner functions from elsewhere, etc. Nicely isolated.

Even with ACPI, the part that will use input will usually be modular,
too.

The only big user of INPUT, which can't be modular at the time is
CONFIG_VT. And this, I believe, is a bug.

-- 
Vojtech Pavlik
Director SuSE Labs

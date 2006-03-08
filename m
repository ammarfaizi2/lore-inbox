Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWCHIoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWCHIoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWCHIoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:44:32 -0500
Received: from gate.perex.cz ([85.132.177.35]:12434 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932461AbWCHIob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:44:31 -0500
Date: Wed, 8 Mar 2006 09:44:29 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound userspace drivers (fishing for insight)
In-Reply-To: <440E5746.7070003@comcast.net>
Message-ID: <Pine.LNX.4.61.0603080939360.9337@tm8103.perex-int.cz>
References: <440E5746.7070003@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, John Richard Moser wrote:

> In general, transporting sound data in and out of kernel space is a
> horrid thought.  Consider the latencies, which all real-time audio
> people will quickly get angry about.  Write sound; context switch; sound
> in driver; context switch back.  This over and over?  Now we all know
> better than that.

Nope. If you have a cache coherent architecture like x86, ALSA mmaps 
directly the DMA buffer to application and even pointers to this buffer 
are mmaped, thus there is no content switch when apps are doing r/w and 
there is "zero data copy". The only contents switch is when apps call
poll(), but you should do it, otherwise you'll eat all cpu time.

> into the kernel; with alsa it's written to a /proc interface, which

Using /proc? Where? I've not noticed it :-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbRGPCI2>; Sun, 15 Jul 2001 22:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267181AbRGPCIT>; Sun, 15 Jul 2001 22:08:19 -0400
Received: from c008-h000.c008.snv.cp.net ([209.228.34.63]:56197 "HELO
	c008.snv.cp.net") by vger.kernel.org with SMTP id <S267180AbRGPCIG>;
	Sun, 15 Jul 2001 22:08:06 -0400
X-Sent: 16 Jul 2001 02:08:04 GMT
Message-ID: <3B524C7D.C7E2129F@acm.org>
Date: Mon, 16 Jul 2001 12:07:57 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <22193.995248318@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> The clash occurred when two DRM objects were linked into the kernel, it
> resulted in two copies of the DRM code in vmlinux and ld spat the
> dummy.  I did a workaround in drivers/char/drm/Makefile for the old
> code so that problem does not exist any more.

Yes, I remember now.

> But even with that workaround, if one DRM object is a module and
> another is built in, the code in drmlib.a sometimes gets compiled for a
> module and sometimes for built in.  AFAIK this does not cause any
> problems but is ugly.  Come to that, the entire drm/Makefile is ugly.

Agreed.

> Note that these problems are not caused by code vs. macros, they are a
> direct effect of the insistence that each DRM object has its own set of
> routines instead of sharing common code.  Using macros removes drmlib
> but still propagates the idea of not sharing code.  As long as it does
> not get in the way of kbuild then I am happy, others may disagree about
> the approach.

The problem is that the "common code" isn't entirely common.  In most
instances, the previously-duplicated code would be different in some
way, with the ordering of initialisation being fairly strict.  The
templates allow for this to occur, with the "common code" residing
outside each driver, at least at the source code level.

There may be a way to get true runtime sharing happening, but again,
you'd have to talk to the guys at VA about this.

-- Gareth

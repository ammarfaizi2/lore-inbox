Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266651AbUBEUhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUBEUeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:34:03 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:35996 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266629AbUBEUdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:33:38 -0500
Date: Thu, 5 Feb 2004 21:33:36 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205203336.GE10547@stud.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> now I got the error which I would expect after erasing the CD and trying
> to mount it

> seems to me like some cache should have been invalidated, but was not

I hit at this problem while I was writing an IDE Atapi simulator for
FAUmachine. The problem is that the kernel asks the CDROM if the 'disc
has changed', which means that the disc was ejected and reinserted, and
if this *isn't* the case the vfs or whatever assumes that the media
hasn't changed and so the buffers will not be flushed. You can cirumvent
this problem if you just eject and load the media back again.

And this isn't an issue of the cdrom (because my virtual cdrom on
FAUmachine has no buffer) but an issue of the kernel caching.

The linux kernel atapi layer makes a TEST UNIT READY and if the media
has changed the cdrom does return an ERR_STAT with a UNIT_ATTENTION
which means that the medium has changed. IF that this the case the
kernel flushes it's buffers.

	Thomas

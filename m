Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbUF2TDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUF2TDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUF2TDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:03:52 -0400
Received: from winds.org ([68.75.195.9]:44436 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S265956AbUF2TDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:03:34 -0400
Date: Tue, 29 Jun 2004 15:03:29 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Mark Haverkamp <markh@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: RE: PATCH: Further aacraid work
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6BA@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0406291454370.26639@winds.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6BA@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, Salyzyn, Mark wrote:

> I believe this nails the problem too.
>
> However, there is a corner case condition lurking on this (See my
> currently unanswered email "error recovery and command completion" on
> linux-scsi) where I try to deal with completing a command while error
> recovery is triggered. Scsi_done will return doing *nothing* effectively
> loosing the command completion.
>
> MarkH, I had talked to you about he addition of the scsi_add_timer
> before calling scsi_done to address this condition. I do not believe
> this to be the (Reliable and/or performance oriented) solution.
>
> Sincerely -- Mark Salyzyn

I've tested out both patches sent to me.

Test 1: aacraid-1.1.5-2245.tgz

Works flawlessly and speedily! The rsync completes, and doing a sync() (as
called during a normal lilo update) takes roughly 1 second as opposed to 20
with the original aacraid patch from Alan Cox. Also, no SCSI hang message ever
appears.

Test 2: Mark Haverkamp's linit.c patch

The "SCSI hang" console message appears just as before during the 'rsync',
however (unlike before) the device is still usable for roughly 30 seconds after
the problem. During these 30 seconds, the 'rsync' process is hung, but I can
still do a 'df', 'ls', and so on. After 30 seconds, the entire /dev/sda locks
up and I have no choice but to reboot the system.

  -Byron


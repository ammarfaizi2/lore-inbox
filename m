Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUHRIaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUHRIaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUHRIaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:30:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:29415 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S264936AbUHRIaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:30:16 -0400
To: Peter Osterlund <petero2@telia.com>
Cc: Julien Oster <lkml-7994@mc.frodoid.org>,
       Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	<m3657iq4rk.fsf@telia.com> <1092686149.4338.1.camel@freddy>
	<m37jrxk024.fsf@telia.com> <87acwt49zl.fsf@killer.ninja.frodoid.org>
	<m3y8kdibgh.fsf@telia.com>
From: Julien Oster <usenet-20040502@usenet.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	Julien Oster <lkml-7994@mc.frodoid.org>,
	Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Date: Wed, 18 Aug 2004 10:25:54 +0200
In-Reply-To: <m3y8kdibgh.fsf@telia.com> (Peter Osterlund's message of "18
 Aug 2004 01:36:30 +0200")
Message-ID: <87fz6k6eel.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

Hello Peter,

>> The following patch on top of your patch adds all commonly used media
>> types to the output and changes CD-R and CD-RW to be detected by
>> profile type. It also reports unconforming non-standard profiles as
>> well as profiles which have a MMC profile definition but are unknown
>> as of the current MMC3 revision.

> Will any of those printk's ever get printed? Media types that can't be
> handled by the packet driver aren't supposed to make it past the
> pkt_good_disc() test.

Quickly looking through it, pkt_good_disc() does the same and drops
media types with unsuitable or invalid profiles.

So my patch is really not useful at that place.

But couldn't you move the "inserted disc is..." messages to
pkt_good_disc()? In the current source you basically duplicate the
switch statement which checks the profile. The printks could be in the
pkt_good_disc() check just as well.

There all profiles might be included and the corresponding media type
printed out, so that the user knows why his disc is unsuitable
(i.e. it's a CD-ROM or DVD-ROM and doesn't do any writing at all).

Regards,
Julien

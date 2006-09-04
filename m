Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWIDR4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWIDR4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWIDR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:56:12 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:22945 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964955AbWIDR4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:56:11 -0400
Date: Mon, 4 Sep 2006 19:51:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 02/16] GFS2: Core locking interface
In-Reply-To: <1157384401.3384.956.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041945310.28823@yvahk01.tjqt.qr>
References: <1157030977.3384.786.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr> 
 <1157360497.3384.888.camel@quoit.chygwyn.com>  <Pine.LNX.4.61.0609041108570.11217@yvahk01.tjqt.qr>
 <1157384401.3384.956.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> >Unfortunately thats not possible as the struct gfs2_sbd is actually
>> >changed lower down the call chain, but only in the lock_dlm module.
>> 
>> +void gfs2_lm_unmount(struct gfs2_sbd *sdp)
>> +{
>> +	if (likely(!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
>> +		gfs2_unmount_lockproto(&sdp->sd_lockstruct);
>> +}
>> 
>> I can't follow... test_bit does not modify *sdp or sdp->sd_flags, and
>> gfs2_unmount_lockproto does not either.
>
>sd_lockstruct is part of the superblock and fields in the lockstruct are
>changed by (for example) fs/gfs2/locking/dlm/mount.c: gdlm_unmount() so
>I don't think its valid to mark the superblock const here (despite being
>a great fan of using const in general).

Ah I just looked, and saw that

  struct {
      struct ... sd_lockstruct;
  } sdp;

sd_lockstruct is not a pointer but a struct in line. Yes, you are right.
It would have been valid only if sd_lockstruct was a pointer to non-const
memory.


Jan Engelhardt
-- 

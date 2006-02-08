Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWBHQTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWBHQTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWBHQTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:19:46 -0500
Received: from peabody.ximian.com ([130.57.169.10]:18066 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1161093AbWBHQTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:19:45 -0500
Subject: Re: [PATCH] inotify: fix one-shot support
From: Robert Love <rml@novell.com>
To: Ingo Oeser <ingo@oeser-vu.de>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200602080852.18179.ingo@oeser-vu.de>
References: <200602080105.k1815her002647@hera.kernel.org>
	 <200602080852.18179.ingo@oeser-vu.de>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 11:16:33 -0500
Message-Id: <1139415393.8883.193.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 08:52 +0100, Ingo Oeser wrote:

> See, now you can just pass IN_ONESHOT behavior flag without any
> events to shoot at, which you couldn't do before. But this makes only
> sense, if we would like to set a multi-shot mask to one-shot now.

Ack!

> Does this transition (multi shot to single shot)makes sense at all? 
> Is it race-free to allow this?.

It should be okay.  This was my intention in the patch.

> So my suggested fix instead of yours would be:
> 
> /* don't let user-space set invalid bits: we don't want flags set */
> mask &= IN_ALL_EVENTS | IN_ONESHOT;
> if (unlikely((mask & IN_ALL_EVENTS) == 0 && !mask_add)) {
> 	ret = -EINVAL;
> 	goto out;
> }
> 
> Would you like a patch on top of the one submitted by you?

Yes, because my patch was already merged by Linus.

	Robert Love


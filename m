Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUHDWbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUHDWbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267467AbUHDWbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:31:39 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:20196 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267465AbUHDWbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:31:35 -0400
References: <1091655857.3088.10.camel@localhost.localdomain>
Message-ID: <cone.1091658687.786019.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Zan Lynx <zlynx@acm.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc2-mm2, staircase sched and ESD
Date: Thu, 05 Aug 2004 08:31:27 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx writes:

> The 2.6.8-rc2-mm2 kernel has the staircase scheduler, right?  Well, I am
> seeing an odd thing.  At least, I think it is odd.
> 
> I'm running Fedora Core 2 and playing music with Rhythmbox.  When I
> watch top sorted by priority, I see esd slowly increase its priority
> until it reaches 38, then it goes back to 20.  ESD is only using 1-2%
> CPU.
> 
> This is causing a problem because doing just about anything in X, like
> bring up a new window or drag a window causes the sound to just stop.
> 
> Why does ESD's priority keep climbing?
> 
> Oh yes, this does not happen if I change /proc/sys/fs/interactive to 0. 
> When it is 0, X's priority climbs faster than ESDs and does not cause
> the problem.

Yes this is a known issue with esd. It basically wakes up far too frequently 
for it's own good. esd should not be required with alsa drivers and 
2.6 since alsa supports sharing of the sound card / mixing on it's own so 
adding esd adds an unnecessary layer to the sound drivers. It ends 
up doing this:
esd->oss emulation->alsa.

Cheers,
Con


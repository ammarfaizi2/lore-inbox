Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264804AbTE1Ry6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTE1Ry6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:54:58 -0400
Received: from 97.190-201-80.adsl.skynet.be ([80.201.190.97]:62733 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S264804AbTE1Ry5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:54:57 -0400
Message-ID: <3ED4FAC0.6090303@trollprod.org>
Date: Wed, 28 May 2003 20:06:56 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs bug exposed by cdev changes
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >       fs/inode.c assumes that any ->delete_inode() will call 
 >clear_inode().
 >procfs instance doesn't. It had passed unpunished for a while; cdev 
 >changes
 >combined with ALSA creating character devices in procfs made it fatal.
 >
 >        Patch follows. It had fixed ALSA-triggered memory corruption 
 >here -
 >what happens in vanilla 2.5.70 is that clear_inode() is not called when
 >procfs character device inodes are freed. That leaves a freed inode on
 >a cyclic list, with obvious unpleasantness following when we try to 
 >traverse
 >it (e.g. when unregistering a device).
 >
 >        Please, apply. Folks who'd seen oopsen/memory corruption after
 >ALSA access - please, check if that fixes all problems.


modprobe snd-intel8x0
rmmod snd-intel8x0

ALSA works for me,

Thanks
Olivier




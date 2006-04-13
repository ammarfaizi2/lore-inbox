Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWDMOXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWDMOXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWDMOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:23:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44746 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964904AbWDMOXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:23:24 -0400
Date: Thu, 13 Apr 2006 16:08:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olivier Galibert <galibert@pobox.com>
cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What is the most efficient way to copy a bunch of files nowadays?
In-Reply-To: <20060411111137.GA13961@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0604131605150.17374@yvahk01.tjqt.qr>
References: <20060411111137.GA13961@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>After having read-only mucked with the headers of a bunch of files[1]
>I've selected a subset of 2500 or so with sizes going from 2K to 85M
>which I want to copy to another directory in the same local
>filesystem.  What is the "best" (

>CPU usage

nice

>fragmentation

What? You can't really influence it.

>wall clock time

Using a filesystem with aggressive caching.

>system responsiveness during and after the copy)

See one above. Set /proc/sys/vm/dirty_ratio high to have the flush taking 
place late, or low to have it "early+often".

>way to copy these files?  read+write, mmap+write, read+mmap, 
>mmap+mmap+memcpy,

It all boils down to the same: read the file and write it back. So all 
your methods cost equally much. With splice() instead of read/write 
however, you may save some cycles.

>something else?  That's with recent kernels, of course.


Jan Engelhardt
-- 

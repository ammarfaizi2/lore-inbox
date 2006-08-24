Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWHXMsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWHXMsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWHXMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:48:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:38090 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751213AbWHXMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:48:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CgjPuXZEl5gf7BSuHc3Xe9r1VZYbPFfOC4GZM8janPLOhuuSJBEB6yK5DNzyTl1gizftbQp4NfQU/5c7cjHkSxt4TgggY7Y4b5/FsYgDdAN7mUJbaJNcWiIXJrz6OyH0TvVIDgp4A3CFD7+P2nhYKtvDbCUmV/l1TCxok2ZjF5Q=
Message-ID: <71a0d6ff0608240548l4a6a3352r6428cf6672a81b64@mail.gmail.com>
Date: Thu, 24 Aug 2006 16:48:39 +0400
From: "Alexander Shishkin" <alexander.shishckin@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: linux framebuffer ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just stumbled upon a funny issue regarding FBIOGET_FSCREENINFO
ioctl command. What it does is filling in a structure called
fb_fix_screeninfo (fb.h) and passes it to userspace. Now the problem
is that if you run 32-bit userspace with a 64-bit kernel, you have
problems because of 2 unsigned long fields in the abovementioned
structure:

 unsigned long smem_start; /* Start of frame buffer mem */
 ...
 unsigned long mmio_start; /* Start of Memory Mapped I/O */

Most of the structure fields that follow smem_start get screwed from
32-bit userspace point.
I take it that applications somehow make use of these fields (at least
kdrive's fbdev does, from what I see).
Now the question is, how do we get around this situation?

-- 
I am free of all prejudices. I hate every one equally.

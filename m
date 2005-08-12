Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVHLBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVHLBG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVHLBG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:06:59 -0400
Received: from gw.goop.org ([64.81.55.164]:11733 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932354AbVHLBG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:06:58 -0400
Message-ID: <42FBF62F.5090205@goop.org>
Date: Thu, 11 Aug 2005 18:06:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Mosberger <davidm@napali.hpl.hp.com>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: suspect code in drivers/char/agp/generic.c
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just looking at agp_copy_info(), which contains this code:

   318 	if (bridge->mode & AGPSTAT_MODE_3_0)
   319 		info->mode = bridge->mode & ~AGP3_RESERVED_MASK;
   320 	else
   321 		info->mode = bridge->mode & ~AGP2_RESERVED_MASK;
   322 	info->mode = bridge->mode;

This looks wrong to me, since line 322 overrides the previous 4 lines'
work...

I have no idea whether this is actually causing a problem, but I'd
thought I'd call attention to it.

    J

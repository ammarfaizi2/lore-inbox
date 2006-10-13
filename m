Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWJMAtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWJMAtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWJMAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:49:20 -0400
Received: from vstglbx99.vestmark.com ([208.50.5.99]:19473 "EHLO
	texas.hq.viviport.com") by vger.kernel.org with ESMTP
	id S1751394AbWJMAtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:49:19 -0400
Date: Thu, 12 Oct 2006 20:49:18 -0400
From: nmeyers@vestmark.com
To: linux-kernel@vger.kernel.org
Subject: Major slab mem leak with 2.6.17 / GCC 4.1.1
Message-ID: <20061013004918.GA8551@viviport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 13 Oct 2006 00:49:18.0811 (UTC) FILETIME=[6A3ABAB0:01C6EE61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been chasing an OOM-death problem on 2.6.17 that showed up while
running a J2EE application on my recently-built Gentoo box. The crash
was ugly - leaking huge numbers of skbuff_head_cache and size-2048 slab
entries until my java processes died and the system became unusable
and unresponsive.

My environment is:

  Gentoo kernel build 2.6.17-gentoo-r8, built with GCC 4.1.1.

I tried Catalin Marinas' kmemleak patches, and had to rebuild with
GCC 3.4.6 because of a 4.1.1 compiler bug that prevents compilation
of the patches.

And... building with 3.4.5 fixed the leak! So I guess I have very little
detail to report - except that there's a nasty leak in 2.6.17 when built
with 4.1.1.

If anyone has a version of kmemleak that I can build with 4.1.1, or
any other suggestions for instrumentation, I'd be happy to gather more
data - the problem is very easy for me to reproduce.

Nathan Meyers
nmeyers@vestmark.com

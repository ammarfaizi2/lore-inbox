Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSGHS60>; Mon, 8 Jul 2002 14:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSGHS6Z>; Mon, 8 Jul 2002 14:58:25 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:7943 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S317107AbSGHS6X>; Mon, 8 Jul 2002 14:58:23 -0400
X-mailer: xrn 8.03-beta-26
From: pmenage@ensim.com (pmenage@ensim.com)
Subject: Re: BKL removal
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: 
In-reply-to: <0C01A29FBAE24448A792F5C68F5EA47D2B0C8A@nasdaq.ms.ensim.com>
Message-Id: <E17RdkT-0007Qt-00@pmenage-dt.ensim.com>
Date: Mon, 08 Jul 2002 12:00:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D2B0C8A@nasdaq.ms.ensim.com>,
you write:
>The BKL, unless used unbalanced, can never cause a bug.
>It could be insufficient or superfluous, but never be really buggy in
>itself.

Unless you're including incorrect nesting in your definition of
"unbalanced", that's not really true. E.g. lock_kernel() anywhere that
dcache_lock is held can deadlock against anywhere that does a path
lookup with the BKL held (such as do_coredump()).

Paul


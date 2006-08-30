Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWH3BIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWH3BIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWH3BIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:08:49 -0400
Received: from mail.parknet.jp ([210.171.160.80]:9476 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932143AbWH3BIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:08:48 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Drop cache has no effect?
References: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
	<20060829110048.20e23e75.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Aug 2006 10:08:39 +0900
In-Reply-To: <20060829110048.20e23e75.akpm@osdl.org> (Andrew Morton's message of "Tue, 29 Aug 2006 11:00:48 -0700")
Message-ID: <87k64rxc6g.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> That would be a vfat problem - the changed permission bits weren't written
> back to disk, so when you re-read them from disk (or, more likely, from
> blockdev pagecache) they came back with the original values.
>
> Does vfat even have the ability to store the seven bits?  Don't think so? 
> If not, permitting the user to change them in icache but not being to write
> them out to permanent store seems rather bad behaviour.

That's dirty area, vfat has one read-only bit only. Yes, I also think
this is strange behaviour. But, I worry app is depending on the
current behaviour, because this is pretty old behaviour.

Umm.., do someone have any strong reason? I'll make patch at this
weekend, and please test it in -mm tree for a bit long time...?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

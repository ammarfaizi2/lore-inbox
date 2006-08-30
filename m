Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWH3BjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWH3BjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWH3BjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:39:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751487AbWH3BjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:39:14 -0400
Date: Tue, 29 Aug 2006 18:39:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Drop cache has no effect?
Message-Id: <20060829183902.be1356b6.akpm@osdl.org>
In-Reply-To: <87k64rxc6g.fsf@duaron.myhome.or.jp>
References: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
	<20060829110048.20e23e75.akpm@osdl.org>
	<87k64rxc6g.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 10:08:39 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > That would be a vfat problem - the changed permission bits weren't written
> > back to disk, so when you re-read them from disk (or, more likely, from
> > blockdev pagecache) they came back with the original values.
> >
> > Does vfat even have the ability to store the seven bits?  Don't think so? 
> > If not, permitting the user to change them in icache but not being to write
> > them out to permanent store seems rather bad behaviour.
> 
> That's dirty area, vfat has one read-only bit only. Yes, I also think
> this is strange behaviour. But, I worry app is depending on the
> current behaviour, because this is pretty old behaviour.
> 
> Umm.., do someone have any strong reason? I'll make patch at this
> weekend, and please test it in -mm tree for a bit long time...?

It is pretty weird that permission bits on vfat can magically change in
response to memory pressure.

But no, I'm not really advocating any changes in this area - I don't recall
any complaints (surprised) and the chances are that if we changed it
(ie: not permit the inode to accept changes which cannot be stored on disk)
then someone's app would break.

otoh, it is pretty bad behaviour...

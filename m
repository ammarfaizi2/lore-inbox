Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbUKXFBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUKXFBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 00:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUKXFBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 00:01:49 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:55814 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261708AbUKXFBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 00:01:46 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87653wxqij.fsf@devron.myhome.or.jp> <20041124032017.GG8040@waste.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 24 Nov 2004 14:00:54 +0900
In-Reply-To: <20041124032017.GG8040@waste.org> (Matt Mackall's message of
 "Tue, 23 Nov 2004 19:20:17 -0800")
Message-ID: <87pt237se1.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Wed, Nov 24, 2004 at 05:24:36AM +0900, OGAWA Hirofumi wrote:
>> Colin Leroy <colin@colino.net> writes:
>> 
>> > It adds MS_SYNCHRONOUS support to FAT filesystem, so that less
>> > filesystem breakage happen when disconnecting an USB key, for 
>> > example. I'd like to have comments about it, because as it 
>> > seems to work fine here, I'm not used to fs drivers and could
>> > have made mistakes.
>> 
>> What cases should these patches guarantee that users can unplug the
>> USB key?  And can we guarantee the same cases by improving autofs or
>> the similar stuff?
>
> Well there can be no guarantees - there will always be a race between
> flush and hot unplug. If we're careful with write ordering, we can
> perhaps arrange to avoid the worst sorts of corruption, provided the
> device does the right thing when it's in the middle of an IO.
>
> But generally I think this is a good idea as it shrinks the window.

Things which I want to say here - do we really need the bogus
sync-mode?

Current fatfs is not keeping the consistency of data on the disk at
all.  So, after all, the data on a disk is corrupting until all
syscalls finish, right?

If so, isn't this too slow? I doubt this is good solution for this
problem (USB key unplugging)...

Well, it seems good as start of sync-mode though.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

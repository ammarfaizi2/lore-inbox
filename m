Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWBLWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWBLWyl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 17:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWBLWyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 17:54:41 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:3975 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751052AbWBLWyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 17:54:41 -0500
Message-ID: <43EFBCA9.1090501@tlinx.org>
Date: Sun, 12 Feb 2006 14:54:33 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk>
In-Reply-To: <20060212212504.GX27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Care to RTFS? I mean, really - at least to the point of seeing what's
> involved in that recursion.
>   
Hmmm...that's where I got the original parameter numbers, but
I see it's not so straightforward.  I tried a limit of
40, but I quickly get an OS hang when trying to reference a
13th link.  Twelve works at the limit, but would take more testing
to find out the bottleneck.

As an algorithmic detail, I can see how
file a->b->c->d... etc can easily use tail-recursion, but I'm not
quite as clear why "prefix-recursion" couldn't be used to reduce
the recursion complexity as in the case:
dir0/, link0->dir0, link1->link2 ... It seems it would be the
left hand compliment of tail recursion.  Not sure what would be
involved, but would eliminate some stack considerations if it was
doable.





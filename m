Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTA2Ib7>; Wed, 29 Jan 2003 03:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTA2Ib7>; Wed, 29 Jan 2003 03:31:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:61430 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265373AbTA2Ib5>;
	Wed, 29 Jan 2003 03:31:57 -0500
Date: Wed, 29 Jan 2003 00:41:33 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: shemminger@osdl.org, torvalds@transmeta.com, andrea@suse.de, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/4) 2.5.59 fast reader/writer lock for gettimeofday
Message-Id: <20030129004133.33de30a8.akpm@digeo.com>
In-Reply-To: <20030129072622.GA18250@krispykreme>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net>
	<20030128230639.A17385@twiddle.net>
	<20030129072622.GA18250@krispykreme>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 08:41:11.0963 (UTC) FILETIME=[2D471EB0:01C2C772]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> > These need to be mb(), not wmb(), if you want the bits in between
> > to actually happen in between, as with your xtime example.  At
> > present there's nothing stoping xtime from being *read* before
> > your read from pre_sequence happens.
> 
> But with frlocks we synchronise writers with a spinlock, so shouldnt it
> provide that synchronisation?
> 

Richard is referring to the new fr_write_begin/end code, which doesn't take a
spinlock because it assumes that writer serialisation has been provided by
external means.


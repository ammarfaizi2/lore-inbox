Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270256AbRH1FBj>; Tue, 28 Aug 2001 01:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRH1FBa>; Tue, 28 Aug 2001 01:01:30 -0400
Received: from www.wen-online.de ([212.223.88.39]:7173 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S270256AbRH1FBX>;
	Tue, 28 Aug 2001 01:01:23 -0400
Date: Tue, 28 Aug 2001 07:01:16 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Dieter N|tzel <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010828010850Z270025-760+6645@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0108280645130.607-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Dieter N|tzel wrote:

> * readahead do not show dramatic differences
> * killall -STOP kupdated DO
>
> Yes, I know it is dangerous to stop kupdated but my disk show heavy thrashing
> (seeks like mad) since 2.4.7ac4. killall -STOP kupdated make it smooth and
> fast, again.

Interesting.

A while back, I twiddled the flush logic in buffer.c a little and made
kupdated only handle light flushing.. stay out of the way when bdflush
is running.  This and some dynamic adjustment of bdflush flushsize and
not stopping flushing right _at_ (biggie) the trigger level produced
very interesting improvements.  (very marked reduction in system time
for heavy IO jobs, and large improvement in file rewrite throughput)

	-Mike


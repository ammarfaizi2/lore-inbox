Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278543AbRJSQ6d>; Fri, 19 Oct 2001 12:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278545AbRJSQ6X>; Fri, 19 Oct 2001 12:58:23 -0400
Received: from colorfullife.com ([216.156.138.34]:47886 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278543AbRJSQ6H>;
	Fri, 19 Oct 2001 12:58:07 -0400
Message-ID: <3BD05BC9.DED0A405@colorfullife.com>
Date: Fri, 19 Oct 2001 18:58:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.13-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> And with
> the floppy case, there was no way to notice at run-time whether the
> unit was broken or not - the floppy drives have no ID's to blacklist
> etc. 

The standard trick is to start with media-change not supported, and
enable it if you get the first change signal.
There are really old floppies that don't support media-change signals,
and they _never_ send it. If you see a media-change signal, then you
know that the floppy is not broken.

Probably a timer (2 seconds) and a delayed cache flush should fix the
problem.

If the device supports media-change and media-lock, then it could
increase the timeout value.

--
	Manfred

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSBNAy2>; Wed, 13 Feb 2002 19:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSBNAyS>; Wed, 13 Feb 2002 19:54:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20755 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287720AbSBNAyB>;
	Wed, 13 Feb 2002 19:54:01 -0500
Message-ID: <3C6B0A70.D11DFC2A@zip.com.au>
Date: Wed, 13 Feb 2002 16:53:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16b9jW-0002QL-00@starship.berlin> <3C6B06E5.F6A7AD9F@zip.com.au>,
		<3C6B06E5.F6A7AD9F@zip.com.au> <E16bA59-0002Qa-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> What's the theory behind writing the data both before and after the commit?

see fsync_dev().  It starts I/O against existing dirty data, then
does various fs-level syncy things which can produce more dirty
data - this is where ext3 runs its commit, via brilliant reverse
engineering of its calling context :-(.  It then again starts I/O
against new dirty data then waits on it again.  And then again.

There's quite a lot of overkill there.  But that's OK, as long
as it terminates sometime.

-

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbTAGU1M>; Tue, 7 Jan 2003 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbTAGU1M>; Tue, 7 Jan 2003 15:27:12 -0500
Received: from nameservices.net ([208.234.25.16]:31062 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S267449AbTAGU1K>;
	Tue, 7 Jan 2003 15:27:10 -0500
Message-ID: <3E1B3975.41201B4B@opersys.com>
Date: Tue, 07 Jan 2003 15:32:53 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] High-speed data relay filesystem
References: <3E1B17DF.BCC51B3@opersys.com> <20030107124016.Z31555@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas Dilger wrote:
> The main drawback is that our 5MB buffer fills in about 1 second on a
> fast machine, so if we had an efficient file interface to user-space
> like relayfs we might be able to keep up and collect longer traces, or
> we might just be better off writing the logs directly to a file from
> the kernel to avoid 2x crossing of user-kernel interface.  I wonder if
> we mmap the relayfs file and write with O_DIRECT if that would be zero
> copy from kernel space to kernel space, or if it would just blow up?

That's similar to how we've been operating for LTT for a while now. The
kernel buffers are allocated using rvmalloc and mmapped to user-space.
When the daemon needs to dump to file, it issues a write using the pointer
to the mmapped area. There's no data crossing the user-kernel interface
at any point. It's a zero-copy system. This way, we've been able to handle
mutli-MB buffers very efficiently (and on fast machines MB trace buffers
fill very fast).

> In any case, having relayfs would probably allow us to remove a bunch
> of excess baggage from our code.

Great, glad you're interested.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279710AbRJYFET>; Thu, 25 Oct 2001 01:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279713AbRJYFEJ>; Thu, 25 Oct 2001 01:04:09 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:14599 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279710AbRJYFD6>;
	Thu, 25 Oct 2001 01:03:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110250504.f9P54VX94424@saturn.cs.uml.edu>
Subject: Re: [Q] cannot fork w/ 1000s of procs (but still mem avail.)
To: Andries.Brouwer@cwi.nl
Date: Thu, 25 Oct 2001 01:04:31 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, tip@internetwork-ag.de
In-Reply-To: <UTC200110102054.UAA09813.aeb@cwi.nl> from "Andries.Brouwer@cwi.nl" at Oct 10, 2001 08:54:22 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice to do as follows:

1. have a process limit, with a default based on memory size
2. have a pid limit, 2x the above + 300, rounded up to 9999, 99999, etc.

So if we require 32 kB per process, then...

  0    to  11 MB  -->  3-digit
 12 MB to 155 MB  -->  4-digit
156 MB to 1.6 GB  -->  5-digit   (max kernel memory on x86)
1.7 GB to  16 GB  -->  6-digit

The 15-bit limit isn't so bad though, as you can see from the
above. On x86, you get 1 PID for every 28 kB of kernel memory.
You will have some other uses for kernel memory too, if we may
assume that this box has some real work to do. So more likely,
you can't really have anywhere near that many processes anyway.

Thus there isn't any good reason to break the old user apps.

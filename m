Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbUCPRaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUCPRaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:30:01 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:30128 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S263994AbUCPR05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:26:57 -0500
Date: Tue, 16 Mar 2004 17:22:24 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com, peterw@aurema.com, ak@muc.de
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040316172224.GF17627@malvern.uk.w2k.superh.com>
Mail-Followup-To: Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	arjanv@redhat.com, peterw@aurema.com, ak@muc.de
References: <1079453698.2255.661.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079453698.2255.661.camel@cube>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 16 Mar 2004 17:27:30.0733 (UTC) FILETIME=[F5E205D0:01C40B7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Albert Cahalan <albert@users.sourceforge.net> [2004-03-16]:
> 
> Fortunately this is a fresh new reason to beg Linus for
> some data. (all previous arguments have been rejected)
> What would be useful for you?
> 
> HZ   (-1 for tickless?)
> USER_HZ
> freq_scale
> some boolean to indicate ppc-like (pure cycle counter) time
> ???

freq_scale would be a good starting point, I think.

However, there is worse.  There is bounds checking on the txc.freq
argument to adjtimex().  IIRC the bounds have changed at various points
in the kernel history, but at one time the limit was +/- 100ppm.  At the
time, I had a mobo with a -300ppm clock error.  To cope with this,
chrony modifies txc.tick to take out the gross error as well as txc.freq
to adjust the fine error.  Therefore, it needs some idea of how tick and
freq inter-relate, and what the valid range of values for tick is.  This
is another mess.  I need to go away and think some more to know info
from the kernel side would make the problem easier to code for, though.

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol

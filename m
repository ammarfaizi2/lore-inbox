Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTDWWoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTDWWoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:44:11 -0400
Received: from almesberger.net ([63.105.73.239]:22534 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264279AbTDWWoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:44:08 -0400
Date: Wed, 23 Apr 2003 19:55:50 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423195550.E3557@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570840000.1051136330@flay>; from mbligh@aracnet.com on Wed, Apr 23, 2003 at 03:18:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> So if people want 0 volume for some reason, they can set *that*
> in userspace.

1) the kernel default is applied before, possibly long before user
   space can provide its own value
2) the kernel itself doesn't use audio for any intentional interaction
   with the user when booting
3) there can be unintentional audio output, e.g. from a source that
   also has a non-zero default setting, or that starts in a random
   state
4) you'll run a user space utility to adjust the volume, probably
   before the user even gets a chance to do anything that would
   cause intentional audio output

So, because of 4), your user space utility better gets it right, no
matter what the kernel does. If it screws up, your user loses.

3) may yield unexpected noise. Given that the expected behaviour
is silence (see 2), any sound at that point would be unexpected.

Because of 1), the kernel default should be such that a value
should be picked that has the least potential of causing unpleasant
surprises before user space takes over.

I don't quite see your point anyway. Because of 2), the only
situations in which a non-zero default would do anything useful
would be

 - if you add audio output when booting a regular kernel

 - if the user-space utility is absent, doesn't work properly, or
   fails completely (if it fails, there'll probably be larger
   obstacles than just adjusting the volume). Since for many
   users, installing a new kernel equals upgrading their
   distribution, fixes to any design errors in that user-space
   part shouldn't be harder to deploy than a kernel-side change.

So are you planning to make the kernel sing a little song for us,
while booting ? :-)

(Now, for some constructive criticism: a user-space utility that
checks if there is on-going audio output with the volume set very
low, and pops up a wizard in such a case, might actually be
helpful. Likewise, audio output without an application accessing
the mixer may warrant a wizard.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRKMV1p>; Tue, 13 Nov 2001 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279407AbRKMV1g>; Tue, 13 Nov 2001 16:27:36 -0500
Received: from sushi.toad.net ([162.33.130.105]:51932 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279326AbRKMV1U>;
	Tue, 13 Nov 2001 16:27:20 -0500
Subject: automatic __init (etc.) propagation
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1005666058.21555.7.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 13 Nov 2001 16:27:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just been preparing a patch for parport_pc.c
and had the unpleasant experience of having to decide
whether certain functions should be tagged "__init" or
"__devinit", etc.  I assume that if I incorrectly label
a function "__init" then an oops will result when the
function is called after init time; and if I incorrectly
fail to label a function with "__init" then it will be dead
code after init time.  Similarly, if I incorrectly label
a function "__devinit" then an oops will result when the
function is called after init time (unless the driver is
compiled with HOTPLUG); and if I incorrectly fail to label
a function with "__devinit" then it will be dead code
after init time (unless the driver is compiled with HOTPLUG,
in which case __devinit makes no difference).

Would it not be possible for this to be handled automatically?
That is, would it not be possible to set things up so that we
tag just the module init function with '__init' and all
those functions (that aren't exported) called only by __init
functions will automatically be treated as __init functions
too?  And similarly with __devinit functions?  Thoughts?

--
Thomas Hood


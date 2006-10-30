Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161523AbWJ3Vil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161523AbWJ3Vil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161522AbWJ3Vil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:38:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44691 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161523AbWJ3Vij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:38:39 -0500
Date: Mon, 30 Oct 2006 13:38:25 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: xemul@openvz.org, dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
Message-Id: <20061030133825.3d10c8c1.pj@sgi.com>
In-Reply-To: <6599ad830610301020y3bc515dbse4f278aad8b03e33@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<4545D51A.1060808@in.ibm.com>
	<4546212B.4010603@openvz.org>
	<6599ad830610301020y3bc515dbse4f278aad8b03e33@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - they require touching every architecture to add the new system calls
> - they're harder to debug from userspace, since you can't using useful
>   tools such as echo and cat
> - changing the interface is harder since it's (presumably) a binary API

To my mind these are rather secondary selection criteria.

If say we were adding a single, per-thread scalar value that each
thread could query of and perhaps modify for itself, then a system call
would be an alternative worthy of further consideration.

Representing complicated, nested, structured information via custom
system calls is a pain.  We have more luck using classic file system
structures, and abstracting the representation a layer up.  Of course
there are still system calls, but they are the classic Unix calls such
as mkdir, chdir, rmdir, creat, unlink, open, read, write and close.

The same thing happens in designing network and web services.  There
are always low level protocols, such as physical and link and IP.
And sometimes these have to be extended, such as IPv4 versus IPv6.
But we don't code AJAX down at that level - AJAX sits on top of things
like Javascript and XML, higher up in the protocol stack.

And we didn't start coding AJAX as a series of IP hacks, saying we can
add a higher level protocol alternative later on.  That would have been
useless.

Figuring out where in the protocol stack one is targeting ones new
feature work is a foundation decision.  Get it right, up front,
forevermore, or risk ending up in Documentation/ABI/obsolete or
Documentation/ABI/removed in a few years, if your work doesn't
just die sooner without a whimper.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

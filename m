Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFSW1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 18:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTFSW1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 18:27:54 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:36248 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261797AbTFSW1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 18:27:53 -0400
Message-ID: <3EF23C70.5010901@oracle.com>
Date: Thu, 19 Jun 2003 15:42:56 -0700
From: Scot McKinley <scot.mckinley@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Myers <jgmyers@netscape.com>
CC: Joel Becker <jlbec@evilplan.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com> <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com> <20030618001534.GJ7895@parcelfarce.linux.theplanet.co.uk> <3EEFB165.5070208@netscape.com> <20030618004214.GK7895@parcelfarce.linux.theplanet.co.uk> <3EF104D7.5050905@netscape.com> <3EF11662.2060102@oracle.com> <3EF22301.1000003@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > io_submit() is incapable of returning operation success notifications.

Exactly, that's why i proposed a new submission interface. ie, to
allow io_submit() to support the "always return async, even IF the
operation has ALREADY completed" paradigm, and another interface
to support the "return synchronous completions on submission"
paradigm.

 > "MAY" is far cry from "MUST".  I object strongly to requiring all
 > callers to io_submit() to be able to handle immediate completions.  In
 > my aio framework, the caller of io_submit() is not in a context where it
 > can invoke completion callbacks, since completion callbacks are not
 > required to be reentrant.

Fine (see interfaces defined above).

 > For the specific conditions under discussion, it was.  The conditions
 > were certainly extremely rare.

Yes, and we've moved past that, since there are other conditions which
are not as rare.

 > The traditional way of dealing with this is to first call the
 > synchronous nonblocking interface, retrying with the asynchronous
 > interface only when the nonblocking one indicates no progress.

Great...i am glad that we atleast agree that the interface is necessary,
tho maybe not on its makeup.

The issue i brought up (bcopy threshold), is not a non-blocking issue,
and the above is not the "traditional", nor the correct way of dealing w/
it. The app should NOT need to make multiple sys-calls to initiate
the io. By far the majority of the existly network aio api's simply
return an indication of the immediate/synchronous completion as a
return indication from a *single* submission routine. There is no
reason why we cannot, also.

Regards, -sm


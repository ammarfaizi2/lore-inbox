Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUHMUWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUHMUWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUHMUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:18:34 -0400
Received: from [66.45.74.15] ([66.45.74.15]:20442 "EHLO sluggardy.net")
	by vger.kernel.org with ESMTP id S267425AbUHMUPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:15:54 -0400
Message-ID: <411D20F2.3030101@sluggardy.net>
Date: Fri, 13 Aug 2004 13:13:38 -0700
From: Nick Palmer <nick@sluggardy.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040405)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: khandelw@cs.fsu.edu
CC: Alex Riesen <fork0@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: select implementation not POSIX compliant?
References: <20040811194018.GA3971@steel.home> <1092256397.512046f64c822@system.cs.fsu.edu>
In-Reply-To: <1092256397.512046f64c822@system.cs.fsu.edu>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khandelw@cs.fsu.edu wrote:
 > select should work for any type of socket. Its based on the type of file
 > descriptor not whether it is stream/dgram.

Agreed, but as Alex Riesen has shown with his test case, the behavior
differs based on the type of socket. This doesn't seem quite right, but
was not my original point.

 > so why should recvmsg return error???? upon closing the socket in 
other thread?
 > wouldn't the socket linger around for some time...

Only if SO_LINGER is on, and then only for the linger time. I would
expect recvmsg to set errno to EINTR or EINVAL indicating that the recv
message was interrupted or is no longer valid since the socket has
closed. This is not the case. Instead it returns 0, and doesn't set errno.

-Nick

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUBIRO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBIROZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:14:25 -0500
Received: from terminus.zytor.com ([63.209.29.3]:5271 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S265263AbUBIROY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:14:24 -0500
Message-ID: <4027BFE7.5040100@zytor.com>
Date: Mon, 09 Feb 2004 09:14:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Does anyone still care about BSD ptys?
References: <1076334541.27234.140.camel@cube>
In-Reply-To: <1076334541.27234.140.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> 
> The BSD-style ptys are used all the time for
> serial port emulation. The SysV-style ones are
> useless for this, since they don't have a fixed
> mapping from master to slave. You might make a
> symlink from /dev/testbox to /dev/ptyp0, then
> configure gdb to use /dev/testbox for remote
> debugging. Then you start a remserial process
> to connect /dev/ttyp0 with port 7455 on some
> terminal server, and on the terminal server you
> have remserial connect port 7455 to /dev/C7.
> Now, whenever you run gdb, you're debugging
> a test box over a serial line connected to the
> terminal server. With SysV-style ttys, you
> can't set up your config as nicely. The above
> would likely have a few extra symlinks BTW.
> 

Eh?!  Have your server process create the appropriate symlinks... 
problem solved.

> In your use of the larger dev_t, please keep
> the first 2047 or 2048 ptys as they are today.
> Let the last major use the full 20-bit minor,
> while restricting the first 7 minors to 8 bits.
> This avoids breaking userspace software.

No bloody way in hell.  However, unless I have a strong reason to the 
contrary I'll keep them on major 136, so your little formula should 
still woprk.

> For example, due to the lack of /proc/*/tty links,
> procps uses min+(maj-136)*256 to guess the number
> of a SysV-style pty. A 32-bit dev_t will be handled
> correctly by procps 3.2 if you extend the pty usage
> as explained above.


> Adding /proc/*/tty links solves the problem as
> well, subject to a linux-2.7.0 version check.

Presumably it should be: subject to an existence check.

	-hpa



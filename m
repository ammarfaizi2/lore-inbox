Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSFMQ1d>; Thu, 13 Jun 2002 12:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSFMQ1c>; Thu, 13 Jun 2002 12:27:32 -0400
Received: from pcls1.std.com ([199.172.62.103]:53210 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id <S317777AbSFMQ13>;
	Thu, 13 Jun 2002 12:27:29 -0400
Message-Id: <200206131626.MAA20634@TheWorld.com>
Date: Thu, 13 Jun 2002 12:26:42 -0400 (EDT)
From: rjh@world.std.com
Reply-To: rjh@world.std.com
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
To: jijo@free.net.ph
cc: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206130908550.985-100000@kalabaw>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun, Federico Sevilla III wrote:
> Suggestions on how to work around this on multiple levels would definitely
> be appreciated. I'll be starting by removing the X font server from our
> file and authentication server onto some high-powered workstation, but I'm
> sure this won't be enough, and knowing that a user process like xfs-daemon
> can drag the Linux kernel down to knees is not very comforting. :(
> 

The protection that you need is provided by "ulimit" on most Unixes.
There are facilities to limit maximum real memory used, maximum virtual
memory, maximum number of processes, etc.  This specific bug in XFree is
one of a general case of inescapable user process bugs.  It resulted in
an almost infinite size malloc() request.  You can acheive the same
effect in any userspace program by just putting malloc() inside an
infinite loop.

If you allow users to run with unlimited memory permission, you are
vulnerable.  The XFree bug will hit more people than usual because it is
common to put the ulimit on regular user logins and forget to place a
limit on the automatically started processes.  The default configuration
from RedHat, SuSE, and others is to start XFree outside the login
system.  You can also place limits on these processes but you need to
examine the startup scripts to install the limits in the right places.

This would then result in a different DoS.  Whenever XFree hits the
memory limit, the malloc's will fail, and XFree will decide what to do
about it.  Depending on the circumstances, XFree may shut down, thus
killing all the X window dependent processes.

R Horn


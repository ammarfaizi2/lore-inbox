Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317914AbSFNN6a>; Fri, 14 Jun 2002 09:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317915AbSFNN63>; Fri, 14 Jun 2002 09:58:29 -0400
Received: from [64.30.11.99] ([64.30.11.99]:39953 "HELO smtp.h3technology.com")
	by vger.kernel.org with SMTP id <S317914AbSFNN63>;
	Fri, 14 Jun 2002 09:58:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Security Coordinator <security@aptusventures.com>
Organization: Aptus Ventures LLC
To: rjh@world.std.com, jijo@free.net.ph
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
Date: Fri, 14 Jun 2002 09:50:57 -0400
X-Mailer: KMail [version 1.3.2]
Cc: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org
In-Reply-To: <200206131626.MAA20634@TheWorld.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020614145331.E95A1137BB@smtp.h3technology.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 June 2002 12:26, rjh@world.std.com wrote:

Exactly, any user without limits can arbitrarily "fork bomb" a system too. A 
shell script and newbie level programming talent is all you need... That 
whole class of DoS are hard to stop. You can do 100 things, like starve a 
system of file handles, open 50,000 listen ports, whatever.  You can set 
limits, but there are not even standard APIs for limiting every conceivable 
exhaustible resource systems allocate. 

> On 13 Jun, Federico Sevilla III wrote:
> > Suggestions on how to work around this on multiple levels would
> > definitely be appreciated. I'll be starting by removing the X font server
> > from our file and authentication server onto some high-powered
> > workstation, but I'm sure this won't be enough, and knowing that a user
> > process like xfs-daemon can drag the Linux kernel down to knees is not
> > very comforting. :(
>
> The protection that you need is provided by "ulimit" on most Unixes.
> There are facilities to limit maximum real memory used, maximum virtual
> memory, maximum number of processes, etc.  This specific bug in XFree is
> one of a general case of inescapable user process bugs.  It resulted in
> an almost infinite size malloc() request.  You can acheive the same
> effect in any userspace program by just putting malloc() inside an
> infinite loop.
>
> If you allow users to run with unlimited memory permission, you are
> vulnerable.  The XFree bug will hit more people than usual because it is
> common to put the ulimit on regular user logins and forget to place a
> limit on the automatically started processes.  The default configuration
> from RedHat, SuSE, and others is to start XFree outside the login
> system.  You can also place limits on these processes but you need to
> examine the startup scripts to install the limits in the right places.
>
> This would then result in a different DoS.  Whenever XFree hits the
> memory limit, the malloc's will fail, and XFree will decide what to do
> about it.  Depending on the circumstances, XFree may shut down, thus
> killing all the X window dependent processes.
>
> R Horn

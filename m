Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRDJXas>; Tue, 10 Apr 2001 19:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRDJXaj>; Tue, 10 Apr 2001 19:30:39 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:61961 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S132474AbRDJXaX>; Tue, 10 Apr 2001 19:30:23 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Let init know user wants to shutdown
Date: Tue, 10 Apr 2001 23:30:22 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9b052e$9od$4@ncc1701.cistron.net>
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04fo$9od$3@ncc1701.cistron.net>
X-Trace: ncc1701.cistron.net 986945422 9997 195.64.65.67 (10 Apr 2001 23:30:22 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9b04fo$9od$3@ncc1701.cistron.net>,
Miquel van Smoorenburg <miquels@cistron-office.nl> wrote:
>SIGTERM is a bad choise. Right now, init ignores SIGTERM. For
>good reason; on some (many?) systems, the shutdown scripts
>include "kill -15 -1; sleep 2; kill -9 -1". The "-1" means
>"all processes except me". That means init will get hit with
>SIGTERM occasionally during shutdown, and that might cause
>weird things to happen.
>
>Perhaps SIGUSR1 ?

In the immortal words of Max Headroom, t-t-talking to myself ;)

In fact, the kernel should probably use a real-time signal
with si_code set to 1 for ctrl-alt-del, 2 for the powerbutton etc.

It should first check if process 1 (init) installed a handler
for that real-time signal. If not, it should use the old
signals (SIGINT for ctrl-alt-del, SIGWINCH for kbrequest).

Mike.


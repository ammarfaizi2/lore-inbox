Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277337AbRJEJgY>; Fri, 5 Oct 2001 05:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277338AbRJEJgN>; Fri, 5 Oct 2001 05:36:13 -0400
Received: from my.nada.kth.se ([130.237.226.101]:40868 "EHLO my.nada.kth.se")
	by vger.kernel.org with ESMTP id <S277337AbRJEJgC>;
	Fri, 5 Oct 2001 05:36:02 -0400
Date: Fri, 5 Oct 2001 11:36:28 +0200 (MET DST)
Message-Id: <200110050936.LAA14156@my.nada.kth.se>
From: "=?ISO-8859-1?Q?Mattias Engdeg=E5rd?=" <f91-men@nada.kth.se>
To: pmenage@ensim.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E15pFHM-0002H1-00@pmenage-dt.ensim.com> (message from Paul
	Menage on Thu, 04 Oct 2001 13:39:36 -0700)
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <E15pFHM-0002H1-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage <pmenage@ensim.com> wrote:
>Except that this enhancement is not completely safe, as if you get more
>than 1024 children reaped (assuming you send two bytes of pid and two
>bytes of status) between checks of the pipe, you'll lose notifications.

Obviously, but the cases where the number of children is bounded below
1024 are rather frequent

>At least if you're only using the pipe to stop select() from blocking,
>you don't care about overflowing the pipe as there's no important
>information in there anyway.

sure, but then you have to put the pid/exit status somewhere else and
do some signal blocking/unblocking. In either case, it's portable,
which polling on /proc/pid isn't


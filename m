Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264627AbSIVXyL>; Sun, 22 Sep 2002 19:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264626AbSIVXyL>; Sun, 22 Sep 2002 19:54:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:53749 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264625AbSIVXyK>;
	Sun, 22 Sep 2002 19:54:10 -0400
Message-ID: <3D8E5950.B74734FF@digeo.com>
Date: Sun, 22 Sep 2002 16:59:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Michael Sinz <msinz@wgate.com>, mks@sinz.org, marcelo@conectiva.com.br,
       Robert Love <rml@tech9.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <3D8B8CAB.103C6CB8@digeo.com> <Pine.LNX.3.96.1020922145444.7597A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2002 23:59:12.0977 (UTC) FILETIME=[0CD51C10:01C26294]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Fri, 20 Sep 2002, Andrew Morton wrote:
> 
> > That seems a reasonable thing to want to do.
> >
> > > ...
> > > The following format options are available in that string:
> > >
> > >        %P   The Process ID (current->pid)
> > >        %U   The UID of the process (current->uid)
> > >        %N   The command name of the process (current->comm)
> > >        %H   The nodename of the system (system_utsname.nodename)
> > >        %%   A "%"
> > >
> > > For example, in my clusters, I have an NFS R/W mount at /coredumps
> > > that all nodes have access to. The format string I use is:
> > >
> > >         sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"
> > >
> >
> > Does it need to be this fancy?  Why not just have:
> >
> >         if (core_name_format is unset)
> >                 use "core"
> >         else
> >                 use core_name_format/nodename-uid-pid-comm.core
> 
> Because this way you can do more things with where you put your dumps,
> such as using one element of this flexible method to select a directory,
> where the dump directories for various applications would be on a single
> NFS server, and dumps for another might be on another server, or all dumps
> of a certain kind could share a filename, where only the latest dump would
> be of interest (or take space).

OK, I'll buy that one.

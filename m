Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264479AbSIVTFm>; Sun, 22 Sep 2002 15:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264486AbSIVTFl>; Sun, 22 Sep 2002 15:05:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50438 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264479AbSIVTFl>; Sun, 22 Sep 2002 15:05:41 -0400
Date: Sun, 22 Sep 2002 15:02:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Michael Sinz <msinz@wgate.com>, mks@sinz.org, marcelo@conectiva.com.br,
       Robert Love <rml@tech9.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
In-Reply-To: <3D8B8CAB.103C6CB8@digeo.com>
Message-ID: <Pine.LNX.3.96.1020922145444.7597A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Andrew Morton wrote:

> That seems a reasonable thing to want to do.
> 
> > ...
> > The following format options are available in that string:
> > 
> >        %P   The Process ID (current->pid)
> >        %U   The UID of the process (current->uid)
> >        %N   The command name of the process (current->comm)
> >        %H   The nodename of the system (system_utsname.nodename)
> >        %%   A "%"
> > 
> > For example, in my clusters, I have an NFS R/W mount at /coredumps
> > that all nodes have access to. The format string I use is:
> > 
> >         sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"
> > 
> 
> Does it need to be this fancy?  Why not just have:
> 
>         if (core_name_format is unset)
>                 use "core"
>         else
>                 use core_name_format/nodename-uid-pid-comm.core

Because this way you can do more things with where you put your dumps,
such as using one element of this flexible method to select a directory,
where the dump directories for various applications would be on a single
NFS server, and dumps for another might be on another server, or all dumps
of a certain kind could share a filename, where only the latest dump would
be of interest (or take space).

The code seems to have very little overhead involved in the parse, and it
gives a good deal of flexibility to the admin. I like the idea of a sysctl
for setting the value, you don't want to have to reboot the system when an
app goes sour and you need to save more than one dump to run it down, or
need to mvoe the dump target dir somewhere with more space.

If you're worried about size make it a compile option, but if I (as an
admin) need any control I really want a bunch of control I can set right
now. I don't think most people will want this option, but it would be
really useful in some cases.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


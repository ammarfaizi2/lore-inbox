Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSJVDRl>; Mon, 21 Oct 2002 23:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSJVDRl>; Mon, 21 Oct 2002 23:17:41 -0400
Received: from 64-215-31-18.mon.frontiernet.net ([64.215.31.18]:1942 "HELO
	gorgor.wingnux.com") by vger.kernel.org with SMTP
	id <S262046AbSJVDRj>; Mon, 21 Oct 2002 23:17:39 -0400
Date: Mon, 21 Oct 2002 23:24:09 -0400
From: Mike Grundy <grund@wingnux.com>
To: linux-kernel@vger.kernel.org
Cc: dprobes@www-124.ibm.com
Subject: Kernel Probes - Is this the same as dynamic probes?
Message-ID: <20021022032409.GA26557@gorgor.wingnux.com>
Reply-To: Mike Grundy <grund@wingnux.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	dprobes@www-124.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks -

Rob posed the question in his merge candidate list. Kprobes is an api
for placing arbitrary break (probes) points in kernel code and provides
for handlers (your function) to execute before and after the probed 
instruction is executed. 

Dynamic probes on the other hand does the same thing ;-)

Vamsi and co. designed kprobes to provide the core of the dprobes
engine: probe point management and insertion, probe point interrupt
handler, and post interrupt clean up (replacing the original
instruction, single stepping it and then putting the probe back) in a
lightweight patch so that it would be more palitable for inclusion in
the kernel.

The next version of dprobes could use the api as well as any module
thrown together to debug a problem (without having to reboot).

Anyway getting back to my quip about dprobes doing the same thing,
dprobes can put probes in kernel or userland code, has a debug engine we
call the dprobes_interpreter that runs probe point handler programs (kind 
of pseudo assembler programs) that can change / record register values,
change / record memory locations, core the process or call LKCD and much
more.

kprobes doesn't have two things (IIRC) it needs to handle userland probe
points, I don't know if this was a planned addition or if Vamsi figured
out a way to handle it within the existing kprobes api.

dprobes has support for i386, s390, s390x, ppc and ppc64. kprobes has
i386 support right now, and after we review and beat upon the code I
posted to the dprobes list tonight, we'll have s390 and s390x support as
well.

Comments welcome.

Thanks
Mike

--
If we blow up, whatever's left of me is kicking your butt!

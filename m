Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVKICRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVKICRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbVKICRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:17:22 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:54657 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030397AbVKICRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:17:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17265.23514.177163.454191@wombat.chubb.wattle.id.au>
Date: Wed, 9 Nov 2005 13:15:54 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: serue@us.ibm.com, Ed Tomlinson <tomlins@cam.org>,
       lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
In-Reply-To: <20051106154225.GA26745@ucc.gu.uwa.edu.au>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
	<20051002045315.GA20946@ucc.gu.uwa.edu.au>
	<200510020857.27065.tomlins@cam.org>
	<20051002141637.GC5211@blackham.com.au>
	<20051010011304.GA28223@sergelap.austin.ibm.com>
	<20051106154225.GA26745@ucc.gu.uwa.edu.au>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bernard" == Bernard Blackham <bernard@blackham.com.au> writes:

Bernard> Apologies for the delay.  On Sun, Oct 09, 2005 at 08:13:04PM
Bernard> -0500, serue@us.ibm.com wrote:
>> Quoting Bernard Blackham (bernard@blackham.com.au): > Some way to
>> request a given PID when cloning/forking (or on the > fly even)
>> would make life easier.
>> 
>> Have you considered any ways of implementing this?  Perhaps the
>> simplest way would actually be to allow a process set to be started
>> in some kind of job/jail/container/vserver, where any userspace
>> query of or by pid uses the virtual pid - which might collide with
>> a virtual pid in some other container - but of course the kernel
>> continues to track by real pids.  So pid 3728 may be vpid 2287 in
>> job 3.  A process inside job 3 just asks to kill -9 2287, whereas a
>> process not in a job must ask to kill pid 3728, and a process in
>> job 2 can't touch tasks in job 3.  Is there another way this could
>> work?

Bernard> I did try this once by having a 'supervisor' process ptrace
Bernard> every resumed process and translate PIDs inside system calls,
Bernard> but this got very messy very fast - particularly for terminal
Bernard> ioctls.  Additionally, it means parents can't get
Bernard> notification of when their children die, and it makes the
Bernard> whole show just that much slower.

Indeed.


For HibernatorII (the checkpoint/restart system developed for UXP/M
and Irix) we introduced a new, privileged, system call : pid_clone()
that took the same args as clone() but an extra PID argument.  If the
process id was available, it'd use it, otherwise it would fail.


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

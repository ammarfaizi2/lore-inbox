Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHVW4H>; Thu, 22 Aug 2002 18:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSHVW4H>; Thu, 22 Aug 2002 18:56:07 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:14061 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318028AbSHVW4G>; Thu, 22 Aug 2002 18:56:06 -0400
Date: Thu, 22 Aug 2002 18:59:58 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_PID changes in 2.5.31
Message-ID: <20020822225957.GA11837@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain> <1029799751.21212.0.camel@irongate.swansea.linux.org.uk> <20020820003346.GA4592@win.tue.nl> <1029804092.21242.18.camel@irongate.swansea.linux.org.uk> <20020822221106.GB5471@win.tue.nl> <1030055266.3151.72.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030055266.3151.72.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 11:27:46PM +0100, Alan Cox wrote:
> On the kernel side I found a ushort pid in coda, but I can't actually
> easily tell if thats a process id or a coda thingy. We have some other
> sloppy pid users but they all appear to be int (eg vt_kern.h)

It's both a process id and a Coda thingy :) It should have been pid_t,
but if you change it in the kernel it will break precompiled binaries in
userspace which still assume it is a 16-bit value. It is not used too
often, only when a process is forked off for conflict resolution.

Luckily, I'm getting close to finalizing a new version of Coda's
userspace which has support for realms (or cells, or whatever other
distributed filesystems like to name it) that already has to break
the kernel-venus interface. So I'll add this to my list of incompatible
changes that can go into the patch.

Jan


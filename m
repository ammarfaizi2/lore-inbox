Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUJDQ3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUJDQ3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUJDQ3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:29:55 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6815 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267549AbUJDQ3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:29:54 -0400
Date: Mon, 4 Oct 2004 09:27:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: George Anzinger <george@mvista.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant cpu clocks V6 [2/3]: Glibc patch
In-Reply-To: <415E3D5A.2010501@redhat.com>
Message-ID: <Pine.LNX.4.58.0410040918420.6172@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0410011259190.18738@schroedinger.engr.sgi.com>
 <415E3D5A.2010501@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Ulrich Drepper wrote:

> Did you ever hear about a concept called binary compatiblity?  Don't
> bother working on any glibc patch.

The patch provides complete backwards compatibility if _ASSUME_POSIX_TIMERS is not set.

If _ASSUME_POSIX_TIMERS is set then the patch assumes that this also
indicates that the cpu timers are available. Which would break binary
compatibility. Is that what you are referring to?

Also it seems the patch does not address clock_getcpuclockid() etc. I can
add that.

I had to take the material from sysdeps/unix/clock_* and put it into
sysdeps/unix/sysv/linux/clock_* because otherwise I would have broken all
the other users of sysdeps/unix/clock_*. I need the fallback to the
timer syscalls for clockids unknown to glibc that would have meant a
significant change to the code in sysdeps/unix/clock_*

I would be very grateful if you could indicate to me what fixes are
necessary to make the patch acceptable.

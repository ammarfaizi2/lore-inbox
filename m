Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSDEAQp>; Thu, 4 Apr 2002 19:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSDEAQe>; Thu, 4 Apr 2002 19:16:34 -0500
Received: from rj.SGI.COM ([204.94.215.100]:50901 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290797AbSDEAQT>;
	Thu, 4 Apr 2002 19:16:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] compile error in 2.4.19-pre5-ac1 
In-Reply-To: Your message of "Thu, 04 Apr 2002 18:45:24 EST."
             <Pine.LNX.3.96.1020404183703.4898A-100000@gatekeeper.tmr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Apr 2002 10:15:54 +1000
Message-ID: <1928.1017965754@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002 18:45:24 -0500 (EST), 
Bill Davidsen <davidsen@tmr.com> wrote:
>  Note of warning to new Redhat users, for some reason /usr/include/linux
>is a directory instead of a symbolic link to /usr/src/linux/include/linux,
>so changes in includes aren't used. Possibly an artifact of the install on
>that system, but something to note. 

That is the way it is meant to be.  /usr/include/{linux,asm} do not
point to some random kernel source, they are _copies_ of the kernel
headers at the time that glibc was built and must not change until you
install a new glibc.

User space applications must not rely on including "current" kernel
headers, you do not know which headers would be available when the app
is installed.  If a user space app requires kernel information then it
must have its own headers that contain that data.  The app must also
cope with being run on newer or older kernels than it was compiled for,
that is, it must handle version skew between user space and kernel
interfaces.  If your design requires a user space application including
"current" kernel headers then your design is broken and you are own
your own.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSC3Dqg>; Fri, 29 Mar 2002 22:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSC3Dq0>; Fri, 29 Mar 2002 22:46:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53521 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312380AbSC3DqQ>;
	Fri, 29 Mar 2002 22:46:16 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which kernel debugger is "best"? 
In-Reply-To: Your message of "Fri, 29 Mar 2002 19:18:39 -0800."
             <3CA52E8F.C8D0E5F8@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Mar 2002 14:46:02 +1100
Message-ID: <2178.1017459962@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 19:18:39 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>Jeremy Jackson wrote:
>> 
>> What are people using?
>
>kgdb.  Tried kdb and (sorry, Keith), it's not in the same
>league.  Not by miles.

kdb and kgdb are aimed at different debugging environments.  kgdb
requires a second machine containing the kernel compiled with -g, kdb
lets you debug directly on the machine that failed, with or without
compiling with -g.  Almost all the differences flow from that design
decision.

Another important niggle to me is that kgdb requires the kernel to be
compiled with frame pointers, because that is all that gdb understands.
On ix86 the extra register pressure from dedicating ebp to frame
pointers can cause Heisenbugs.  kdb works with and without frame
pointers.

Can kgdb handle the special hard wired calls that do not add frame
pointers, such as __down_failed?  I doubt that gdb knows how to handle
those.

I am not knocking kgdb, it has its place.  I see a spectrum of
debugging tools from UML through kgdb to kdb, each tool is aimed at a
different debugging environment.  Pick the right tool.


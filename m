Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSGMRLO>; Sat, 13 Jul 2002 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGMRLN>; Sat, 13 Jul 2002 13:11:13 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:40204 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315207AbSGMRLM>;
	Sat, 13 Jul 2002 13:11:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207131713.g6DHDtD95314@saturn.cs.uml.edu>
Subject: Re: [patch[ Simple Topology API
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 13 Jul 2002 13:13:55 -0400 (EDT)
Cc: colpatch@us.ibm.com (Matthew Dobson), linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com (Michael Hohnbaum),
       mjbligh@us.ibm.com (Martin Bligh),
       torvalds@transmeta.com (Linus Torvalds),
       akpm@zip.com.au (Andrew Morton)
In-Reply-To: <Pine.GSO.4.21.0207130355180.13648-100000@weyl.math.psu.edu> from "Alexander Viro" at Jul 13, 2002 04:04:51 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> It's hard to enjoy the use of prctl().  Especially for things like
> "give me the number of the first CPU in node <n>" - it ain't no
> process controll, no matter how you stretch it.

Yeah... eeew.

> <soapbox> That's yet another demonstration of the evil of multiplexing
> syscalls.  They hide the broken APIs and make them easy to introduce.
> And broken APIs get introduced - through each of these.  prctl(), fcntl(),
> ioctl() - you name it.  Please, don't do that. </soapbox>

This wouldn't happen if it wasn't so damn hard to add a syscall.
If you make people go though all the arch maintainers just to
add a simple arch-independent syscall, they'll just bolt their
code into some dark hidden corner of the kernel. That's life.
Make syscalls easy to write, and this won't happen.

Can you guess what would happen if you got rid of prctl(),
fcntl(), and ioctl()? We'd get apps with code like this:

// write address of one of these to /proc/orifice
typedef struct evil {
  int version;        // struct version
  struct evil *next;  // next in list
  struct evil *prev;  // prev in list
  char opcode;        // indicates what we will do
  int (*fn)(void *);  // callback function (if not NULL)
  void *addr;         // an address in kernel memory
  short flags;        // 0x0001 call fn w/ ints off, 0x0002 w/ BKL
  double timeout;     // in microfortnights (uses APIC's NMI)
} evil;




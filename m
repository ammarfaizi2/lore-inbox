Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTAPBCV>; Wed, 15 Jan 2003 20:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTAPBCV>; Wed, 15 Jan 2003 20:02:21 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:43765 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S266944AbTAPBCU>; Wed, 15 Jan 2003 20:02:20 -0500
Date: Wed, 15 Jan 2003 20:04:54 -0500
From: Alex <akhripin@MIT.EDU>
To: linux-kernel@vger.kernel.org
Subject: Dynamic memory stack?
Message-ID: <20030116010454.GB3288@dodecahedron.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A good way to prevent memory leaks and simplify code is to reduce the use of
kmalloc for a certain class of situations. Specifically, I am referring to
blocks of code with the following:

bar(){
.
.
foo=kmallc
.
.
.
kfree(foo)
.
.
}

This sort of thing is best handled on the stack, but, of course, that has
critical flaws. A way to deal with this is to create a per-cpu kmalloc'ed
dynamically extended stack from which memory can be allocated. Then, most
allocations/deallocations are done in O(1) and memory fragmentation due to
lots of small allocation is avoided.
Furthermore, with the help of macros, memory leaks due to mid-function returns
and such can be completely avoided.
A survey of kernel code revealed a number of places where this methodology can
be applied.
-Alex Khripin

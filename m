Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUDZQ7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUDZQ7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDZQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:59:05 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:2232 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263045AbUDZQ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:59:00 -0400
Message-ID: <408D3FEE.1030603@namesys.com>
Date: Mon, 26 Apr 2004 09:59:26 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org
Subject: I oppose Chris and Jeff's patch to add an unnecessary additional
 namespace to ReiserFS
References: <1082750045.12989.199.camel@watt.suse.com>
In-Reply-To: <1082750045.12989.199.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding additional namespaces is not a trivial thing to do, though it 
always seems so minor to the person driven by marketing to quickly hack 
something in.

The xattr namespace offers zero functional advantage over the file 
namespace.  The use of '.' instead of '/' is idiotic, see the very short 
paper "The Hideous Name" by Rob Pike  ( www.cs.bell-labs.com/cm/cs/doc/ 
) for why mindlessly varying the separators in hierarchical names 
throughout an OS is a bad idea. 

V4 of ReiserFS accesses all file attributes via the filesystem namespace 
(see our mainpage at www.namesys.com, there is a section on semantics in 
it).  In V4, attributes are just files with peculiar qualities, kind of 
like the files in /proc have peculiar qualities.  V4 adds some 
additional functionality to the filesystem namespace to make this more 
effective (accessing multiple files in one system call, etc.). 

Namespaces are the roads and waterways of an operating system.  The cost 
of developing an operating system is proportional to how many components 
you build into it.  Namespaces are part of what determines whether that 
cost is linear with the number of components, or something worse. 

The expressive power of an operating system is NOT proportional to the 
number of components, but instead is proportional to the number of 
possible connections between its components.  If you fragment the 
namespaces of an OS, you reduce each component to effective interactions 
with only those components in its reduced size namespace.  Designing the 
namespaces of an OS so that they possess closure and are unified may 
seem like a lot of effort, but it is very cost effective compared to 
building many times more other OS components to get the same expressive 
power.

In the free software community you have to produce working code to be 
paid attention to.  We are doing that.  Chris is sending his patch in at 
this time in part because V4 is about to make his work completely 
obsolete.  At the time he started to write the patch he was told that 
ReiserFS was taking this other approach, and his patch would never be 
accepted so he should not write it.  DARPA was then convinced to fund us 
to do the other approach, and we accepted $600k in funding to (among 
other things) extend the filesystem namespace to access security 
attributes effectively.  I have no desire to change direction at the 
last moment before we ship V4 so as to become less elegant.  I also view 
V3 as stable code that should not be disturbed more than minimally 
necessary, and I desire for all new functionality to go into V4 (Chris 
was also told that before his patch was written).

Making it possible to unify operating system namespaces was why ReiserFS 
was created.  I am not in this for the money.  Pasting in an additional 
namespace beyond what Unix had for short term marketing reasons violates 
its soul, and I have no desire to provide support for it as it 
complicates one feature at a time over 30 years.

Please, let our competing solution of more unified naming have this 
ecological niche it can survive in long enough to see if it is the right 
longterm direction for Linux.  It is more work to be elegant, and it 
will cause application writers some short term pain, but in 30 years you 
will not regret trying it.

Please reject the xattr and acl patch for ReiserFS V3, and wait a week 
or two for ReiserFS V4 to ship to you instead.

Hans

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSKCQGr>; Sun, 3 Nov 2002 11:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSKCQGr>; Sun, 3 Nov 2002 11:06:47 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23437 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262107AbSKCQGq>; Sun, 3 Nov 2002 11:06:46 -0500
Subject: Re: [lkcd-general] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>, Steven King <sxking@qwest.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.3.96.1021103092330.5197D-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021103092330.5197D-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 16:32:55 +0000
Message-Id: <1036341175.29646.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 14:33, Bill Davidsen wrote:
> If you define "unmaintainably bad" as "having features you don't need"
> then I agree. But since dump to disk is in almost every other commercial
> UNIX, maybe someone would question why it's good for others but not for
> Linux.

It isnt about features, its about clean maintainable code. netdump to me
doesnt mean no dump to disk option. In fact I'd rather like to be able
to insmod dump-foo.o. The correctness issues are hard but if the
dump-foo is standalone, resets the hardware and has an SHA integrity
check then it can be done (think of it as a post crash variant of the
trusted computing TCB verification problem)

> uses the crash dump in AIX, the person who wants to send a compressed dump
> and money to IBM and get back a fix. Netdump assumes external resources

Lots of interesting legal issues but yes you can do it sometimes (DMCA,
privacy, financial duties sometimes make it horribly complex). Even in
the case where you only dump the oops its still valuable.

> and a functional secure network (is the dump encrypted and I missed it?)
> which home users surely don't have, and remote servers oftem lack as well.

Encrypting the dump with the new crypto lib in the kernel would be easy,
right now it doesnt. 

My disk dump concerns are purely those of correctness. That means

1.	After loading the module getting the block list for the dump target

2.	Resetting and scratch initializing the dump device

3.	Not relying on any code outside of the dump TCB that may have
been corrupted

4.	At dump time turning off all bus masters, doing the dump TCB
verification and then dumping

Most of the pieces already exist.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271636AbTGQXeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271638AbTGQXeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:34:21 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:33032 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S271636AbTGQXeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:34:20 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Date: Thu, 17 Jul 2003 23:49:15 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bf7clr$ang$1@news.cistron.nl>
References: <20030716184609.GA1913@kroah.com> <20030718002451.A2569@pclin040.win.tue.nl> <20030717224307.GF19891@ca-server1.us.oracle.com> <20030718011115.A2600@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1058485755 10992 62.216.29.200 (17 Jul 2003 23:49:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030718011115.A2600@pclin040.win.tue.nl>,
Andries Brouwer  <aebr@win.tue.nl> wrote:
>On Thu, Jul 17, 2003 at 03:43:08PM -0700, Joel Becker wrote:
>> On Fri, Jul 18, 2003 at 12:24:51AM +0200, Andries Brouwer wrote:
>> > Premise: some filesystems or archives store 32 bits.
>> > Conclusion: we must be able to handle that.
>> > This is unrelated to the kernel, unrelated to system calls,
>> > it is related to <sys/sysmacros.h>.
>> 
>> 	How does linux handle that today?  IIRC, it ignores the high
>> 16bits and treats that 32bit number as 8:8.  That is what happens today,
>> for every filesystem, whether it stores 32 or 16 bits.
>> 	Why expand that?  We can continue to treat 32bit numbers (eg,
>> from NFSv2) as 16bit numbers.
>
>:-) A surprising question.
>Why expand that?
>Because we would like to use more than 16 bits in device numbers.

But why do you need a 32bit interface to the kernel when a
32:32 interface exists? Userland can translate 32 bit major/minor
into 32:32 to the kernel, if a 64 bits syscall exists, right 
CAse in point: mknod64()

Same goes for filesystems. A 32 bit on-disk rdev doesn't need to
be handled by the rest of the kernel. The filesystem driver just
needs to translate it to 32 major 32 minor for the rest of the
kernel.

Mike.


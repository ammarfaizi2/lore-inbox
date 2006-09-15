Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWIODKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWIODKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 23:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWIODKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 23:10:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:25510 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751480AbWIODKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 23:10:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OPHu9q80AIbPC/wADZhyDN708Np5NHVz4ov+QfzjJeXn1zuMrI7M09/eT7wFjJFzvWJ/mnrv9tC7wrQyX+F0ZLH0IoqDaM5nuLEs9Bv7Uqzy/mslW9y73Y3Yvp2FP6FxeMNIwwaMSlzq88vMY/mHDrip7SsmasT77GWB1cFJ7mY=
Message-ID: <cd09bdd10609142010j2ce007d4j8feb6f7de871a1b1@mail.gmail.com>
Date: Thu, 14 Sep 2006 22:10:43 -0500
From: "James Dickens" <jamesd.wi@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Static probe points in the mainline kernel should not be there for
kernel programmers. Any kernel programmer that is interested in an
event that a static probe would trace, could with a little work use
kprobes, Systemtap, printk,  statements or numerous other methods and
accomplish the same thing most likely with less impact on the kernel.

If you allow static probe points, do them for the people that use your
code,  If static probing is to work in the mainline kernel, its
necessary for everyone to see the value of them.

I came up with some simple rules that may help the adoption of static
probe points in the kernel. They answer a lot of issues I read in
other reads.

Some simple rules for Static Probing:

- If the probe is not enabled, it turns into a NOP. No probes are
enabled by default
- Each programmer should provide this as a service to the user.
- There should be at most a 1000 static probe points in the entire
kernel including modules, drivers, etc.
- Probes should not pass out any more information than what a user
would need. If the user needs more he needs to find another way to get
it, perhaps dynamic probing.
- If any part of the kernel has more than a dozen probe points there
are too many.
- If a probe would be of little use to a user/sysadmin it should be
removed from the mainline kernel.
- Yes, if a probe point is in the code you are working on, the role of
maintaining it falls on you.
- If you notice your code is doing something that matches a statically
probed event (.i.e. your network driver dropped a packet), it's your
responsibility to add the necessary probe in your code.
- If "you" need a probe that would not be needed except for debugging
your code, use one of the other methods mentioned above, or remove it
before your code is submitted to the mainline kernel.


Some example static probe points

Task going is being moved on to a cpu.
Task moving off a cpu

Start of an IO
End of an IO

Network packet received
Packet dropped.

Various lock activities
Lock taken
Spin lock taken


James Dickens
uadmin.blogspot.com

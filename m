Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271771AbRHUSIL>; Tue, 21 Aug 2001 14:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271772AbRHUSIB>; Tue, 21 Aug 2001 14:08:01 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:38958 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S271771AbRHUSHn>; Tue, 21 Aug 2001 14:07:43 -0400
Message-Id: <4.3.2.7.2.20010821084512.00bdf800@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 21 Aug 2001 11:07:54 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: FYI  PS/2 Mouse problems -- userland issue
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last week I had asked about mouse problems.  I have discovered the root 
cause.  This affects you if (1) you are using a KVM switch and (2) you have 
a "wheel" mouse.

The problem is that sometime during system initialization the mouse is 
being configured as a generic PS/2 mouse (no wheel).  This works 
fine...until you switch the mouse away from the system.  Depending on the 
KVM switch you are using, the mouse MAY reset itself into its native 
mode.  In the case of the Logitech wheel mice, this means that each mouse 
event sends four codes instead of three.  The X mouse support doesn't like 
that very much.  :)

This MAY be a kernel issue depending on where I locate the mouse 
initialization code.  If it is in the kernel, then there will need to be a 
patch to allow the mouse to be re-initialized into the mode everyone expects.

Satch


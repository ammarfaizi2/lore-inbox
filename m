Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVEDNWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVEDNWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEDNWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:22:23 -0400
Received: from alog0497.analogic.com ([208.224.223.34]:59602 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261795AbVEDNWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:22:15 -0400
Date: Wed, 4 May 2005 09:22:09 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: System call v.s. errno
Message-ID: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know for sure if global 'errno' is supposed to
be altered after a successful system call? I'm trying to
track down a problem where system calls return with EINTR
even though all signal handlers are set with SA_RESTART in
the flags. It appears as though there may be a race somewhere
because if I directly set errno to 0x1234, within a few
hundred system calls, it gets set to EINTR even though all
system calls seemed to return 'good'. This makes it
hard to trace down the real problem.

The answer is not obvious because the 'C' runtime library
doesn't really give access to 'errno' instead it is dereferenced
off some pointer returned from a function called __errno_location().

This problem does not exist with Linux-2.4.x. It started to show
up when user's updated their machines to newer RH stuff that uses
linux-2.6.5-1.358.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

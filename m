Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUIMDYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUIMDYI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUIMDYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:24:08 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:64759 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265161AbUIMDYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:24:04 -0400
Subject: Re: /proc/sys/kernel/pid_max issues
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: wli@holomorphy.com, cw@f00f.org, mingo@elte.hu, anton@samba.org
Content-Type: text/plain
Organization: 
Message-Id: <1095045628.1173.637.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Sep 2004 23:20:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> it's getting quite spaghetti ... do we really want to handle
> RESERVED_PID? There's no guarantee that any root daemon wont stray out
> of the 1...300 PID range anyway, so if it has an exploitable PID race
> bug then it's probably exploitable even without the RESERVED_PID
> protection.

Purpose:

1. weak security enhancement
2. cosmetic (backwards, IMHO)
3. speed (avoid PIDs likely to be used)

I'd much prefer LRU allocation. There are
lots of system calls that take PID values.
All such calls are hazardous. They're pretty
much broken by design.

Better yet, make a random choice from
the 50% of PID space that has been least
recently used.

Another idea is to associate PIDs with users
to some extent. You keep getting back the same
set of PIDs unless the system runs low in some
global pool and has to steal from one user to
satisfy another.

BTW, since pid_max is now adjustable, reducing
the default to 4 digits would make sense. Try a
"ps j" to see the use. (column width changes if
you change max_pid)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUFJVe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUFJVe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUFJVe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:34:29 -0400
Received: from mail.inter-page.com ([12.5.23.93]:50703 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S263089AbUFJVeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:34:08 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Thu, 10 Jun 2004 14:33:32 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAzI6U6wXL/0SmJUi+8GC7hAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <40C8AF31.1010704@tmr.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note my refining email elsewhere in this thread...

I am talking about the default handling of programs that are not marked PT_GNU_STACK.
The proposed /proc/self/NX file tweak does nothing to programs with the protected
stack flag (they are "locked" against executable data, instead of just resistant to
it).

It is better to protect "most of" these uncontrollable, old, legacy, or closed source
apps by default, and provide a means for those that must have it otherwise (e.g.
WINE) to exercise some control as to when or if the exposure is granted.

Consider a "sort of savvy normal user." I go and get this kernel, and build it, and
put it on my existing box.  My security level has changed not-at-all because none of
my apps are marked PT_GNU_STACK.  I don't actually see any improvement until I
recompile my distro.

With the proposed change the default can be everything-is-NX but unmarked apps can
"demote themselves" to the old behavior.  I discover that I have some app that breaks
hideously.  I can use a shim "LD_PRELOAD=libEX.so app" that opens the NX restriction
for that app.

Yes, this "raises the exposure" for all the "protected by default" apps if the
program is broken enough and the attacker is savvy enough, but these old apps have no
protection under the new system anyway, so better to protect most of them, and let
some of them slip-by if they need to, than protect none of them at all.

Rob.

-----Original Message-----
From: Bill Davidsen [mailto:davidsen@tmr.com] 
Sent: Thursday, June 10, 2004 11:58 AM
To: Robert White
Cc: linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2

Robert White wrote:
> I would think that having an easy call to disable the NX modification would be both
> safe and effective.  That is, adding a syscall (or whatever) that would let you
mark
> your heap and/or stack executable while leaving the new default as NX, is "just as
> safe" as flagging the executable in the first place.

It clearly wouldn't be safe, and that keeps it from being effective. 
Like having a great lock and burglar alarm, then putting the key and 
entry code under the mat. NX is to prevent abuse by BAD PEOPLE and 
therefore should not have any way to defeat it from within a program.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me




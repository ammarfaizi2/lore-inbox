Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269218AbTCBOGJ>; Sun, 2 Mar 2003 09:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269219AbTCBOGJ>; Sun, 2 Mar 2003 09:06:09 -0500
Received: from daimi.au.dk ([130.225.16.1]:27868 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S269218AbTCBOGH>;
	Sun, 2 Mar 2003 09:06:07 -0500
Message-ID: <3E621235.2C0CD785@daimi.au.dk>
Date: Sun, 02 Mar 2003 15:16:21 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
CC: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
> 
> If 'mount' treats specially the
> mtab if it is a symlink... well, IMHO this is not correct. Yes, this
> can lead to an attack, but: 'mount' is a setuid program, and only
> root can symlink /etc/mtab, true?

The reason for mount not to update /etc/mtab if it is a symlink is
not security concerns, but rather that it could be a symlink to
/proc/mounts. Another problem is the way the update is actually
done. A lockfile named /etc/mtab~ is created, and a new mtab is
written to /etc/mtab.tmp which is later renamed on top of mtab.

Some of this can obviously be solved by changing mount. But if we
are going to change mount in non-trivial ways, we should aim for a
better longterm solution. It would be possible for mount to start
from /et/mtab and use readlink until the actual location is found.
Then if the path starts with /proc/ the update can be skipped, or
done in a different way. And if the location is outside /proc then
create lockfilename and tempfilename by appending to this path.

But all that is IMHO a bad solution. Getting the actual location
right is nontrivial. And we should rather aim for an implementation
in /proc and have mount write there directly. But there are a few
open questions I'd like answered before trying to implement a
/proc/mtab.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);

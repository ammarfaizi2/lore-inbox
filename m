Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268156AbTCCAxu>; Sun, 2 Mar 2003 19:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268220AbTCCAxu>; Sun, 2 Mar 2003 19:53:50 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:35855 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S268156AbTCCAxs>; Sun, 2 Mar 2003 19:53:48 -0500
Date: Sun, 2 Mar 2003 17:04:09 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030303010409.GA3206@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E621235.2C0CD785@daimi.au.dk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 03:16:21PM +0100, Kasper Dupont wrote:
> DervishD wrote:
> > 
> > If 'mount' treats specially the
> > mtab if it is a symlink... well, IMHO this is not correct. Yes, this
> > can lead to an attack, but: 'mount' is a setuid program, and only
> > root can symlink /etc/mtab, true?
> 
> The reason for mount not to update /etc/mtab if it is a symlink is
> not security concerns, but rather that it could be a symlink to
> /proc/mounts. Another problem is the way the update is actually
> done. A lockfile named /etc/mtab~ is created, and a new mtab is
> written to /etc/mtab.tmp which is later renamed on top of mtab.
> 
> Some of this can obviously be solved by changing mount. But if we
> are going to change mount in non-trivial ways, we should aim for a
> better longterm solution. It would be possible for mount to start
> from /et/mtab and use readlink until the actual location is found.
> Then if the path starts with /proc/ the update can be skipped, or
> done in a different way. And if the location is outside /proc then
> create lockfilename and tempfilename by appending to this path.
> 
> But all that is IMHO a bad solution. Getting the actual location
> right is nontrivial. And we should rather aim for an implementation
> in /proc and have mount write there directly. But there are a few
> open questions I'd like answered before trying to implement a
> /proc/mtab.

You are talking about adding hacks to workaround the
original hack.  Nothing should write to mtab.  Say it with
me "Nothing should write to mtab".

mount(8) and umount(8) are the only almost the only things that
write mtab all others are readers.  I may be wrong but the
data argument to mount(2) looks like it should support
everything missing from /proc/mounts.  Alternatively change
mount(2) and mount(8) and any other mount(2) callers will
be revealed.

The reason to leave a /etc/mtab symlink is so that the
old tools other than (u)mount don't need updates.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

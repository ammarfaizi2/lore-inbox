Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTLKOXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbTLKOXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:23:50 -0500
Received: from main.gmane.org ([80.91.224.249]:32656 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264978AbTLKOXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:23:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
Date: Thu, 11 Dec 2003 15:23:44 +0100
Message-ID: <yw1x3cbrh1qn.fsf@kth.se>
References: <20031211133124.GA18161@alpha.home.local> <Pine.LNX.4.44.0312111351520.1386-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ukedcTr9eJ0pC7ihBKAQwH3ZkXw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> On Thu, 11 Dec 2003, Willy Tarreau wrote:
>
>> On Thu, Dec 11, 2003 at 10:54:28AM -0200, dual_bereta_r0x wrote:
>> > root@hquest:/tmp# cat /etc/slackware-version
>> > Slackware 9.1.0
>> > root@hquest:/tmp# uname -a
>> > Linux hquest 2.4.23 #6 Sat Nov 29 22:47:03 PST 2003 i686 unknown unknown 
>> > GNU/Linux
>> > root@hquest:/tmp# df /tmp
>> > Filesystem           1K-blocks      Used Available Use% Mounted on
>> > tmpfs                   124024    112388     11636  91% /tmp
>> > root@hquest:/tmp# du -s .
>> > 32      .
>> > root@hquest:/tmp# _
>> 
>> maybe you have a process which creates a temporary file in /tmp, and deletes
>> the entry while keeping the fd open. vmware 1.2 did that, and probably more
>> recent ones still do. It's a very clever way to automatically remove temp
>> files when the process terminates.
>
> That's right, and would explain why du may show 32 even if ls -alR
> shows nothing at all (what does ls -alR /tmp show?).
>
> But the strange thing is that df's Used does not match du: they should
> be identical, though arrived at from different directions.  I've not
> seen that, and have no idea what's going on: it's as if a subtree of
> /tmp has become detached (a non-empty directory removed).

FWIW, I've seen this behavior with vmware 4.  The space came back when
I closed vmware.

-- 
Måns Rullgård
mru@kth.se


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUAPBAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbUAPBAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:00:31 -0500
Received: from main.gmane.org ([80.91.224.249]:49813 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264155AbUAPBAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:00:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
Date: Fri, 16 Jan 2004 01:56:51 +0100
Message-ID: <yw1xwu7sr9rg.fsf@kth.se>
References: <E1AeMqJ-00022k-00@minerva.hungry.com> <2flllofnvp6.fsf@saruman.uio.no>
 <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
 <1073814570.4431.3.camel@laptop.fenrus.com>
 <817jzsd8lg.wl@omega.webmasters.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ILp5ispdmwItBwrxc53sPptW2JA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GOTO Masanori <gotom@debian.or.jp> writes:

> At Sun, 11 Jan 2004 10:49:30 +0100,
> Arjan van de Ven wrote:
>> > 6 does seem pretty low.  What was the reason for setting it there?  Is
>> > there a downside to increasing it?
>> 
>> It was reduced down from 8 because it can lead to stack overflows.
>> Recursive links like this usually point at a quite broken filesystem
>> setup too afaik.
>
> But I still think 6 is too small from user level point of view, as
> Petter wrote.  The example is /usr/lib library links.  I got bug
> report which complained that a library want to use "bounce" link:
>
> 	/usr/lib/liba -> /etc/alternatives/liba -> /usr/lib/another/libb.
>
> If .so file uses major.minor scheme, then /usr/lib/liba.so links:
>
> 	/usr/lib/liba.so -> /usr/lib/liba.so.2 -> /usr/lib/liba.so.2.3
>
> and so on.  It can easily exceed 6 symlinks.  I think the correct fix
> is to make VFS not to overflow stacks.  Is it allowable change?

One of the reasons for the limit is that it doesn't require any
special detection of circular links.

-- 
Måns Rullgård
mru@kth.se


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbTGHAZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbTGHAZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:25:26 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:15524 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266279AbTGHAZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:25:21 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 17:32:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
In-Reply-To: <20030708003247.GB12127@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307071730190.3524@bigblue.dev.mcafeelabs.com>
References: <20030707154823.GA8696@srv.foo21.com>
 <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com>
 <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
 <20030708003247.GB12127@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > Try out this one, either over 2.5.74 or over an existing epoll-patched
> > 2.4.{20,21} ...
>
> Sorry, can't try it out.
> But I have a question anyway :)
>
> Does this correctly free everything when you:
>
> 	declare interest in some events on fd 3
> 	dup2(3,4)
> 	close(3)
> ?

Neither the old and the new code does it. Cleanup is done either with an
EPOLL_CTL_DEL (explicitly) or with the file* removal (__fput()). In you
case when you close(4) if you do not do it explicitly.



- Davide


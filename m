Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270433AbTGMXCD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270434AbTGMXCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:02:03 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:59783 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270433AbTGMXCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:02:02 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 16:09:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: Jamie Lokier <jamie@shareable.org>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.55.0307131605480.15022@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, David Schwartz wrote:

> 	It's not O(N) with 'poll' and 'select'. Twice as many file descriptors
> means twice as many active file descriptors which means twice as many
> discovered per call to 'poll'. If the calls to 'poll' are further apart

It is O(N), if N if the number of fds queried. The poll code does "at least"
2 * N loops among the set (plus other stuff), and hence it is O(N). Even
if you do N "nop" in your implementation, this becomes O(N) from a
mathematical point of view.



- Davide


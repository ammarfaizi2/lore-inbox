Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUDASZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUDASZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:25:51 -0500
Received: from [212.44.21.72] ([212.44.21.72]:20710 "EHLO watergate.zeus.co.uk")
	by vger.kernel.org with ESMTP id S263031AbUDASZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:25:26 -0500
Date: Thu, 1 Apr 2004 19:25:17 +0100 (BST)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: linux-kernel@vger.kernel.org
Subject: Re: epoll reporting events when it hasn't been asked to
Message-ID: <Pine.LNX.4.58.0404011909350.3066@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1B96sP-0001qF-00*s90/pa4eA4Q* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is a feature. epoll OR user events with POLLHUP|POLLERR so that even if
> the user sets the event mask to zero, it can still know when something
> like those abnormal condition happened. Which problem do you see with this?

What should the application do if it gets events that it didn't ask for?
If you choose to ignore them, the next time epoll_wait() is called it
will return instantly with these same messages, so the app will spin and
eat CPU.

The alternative is to put some kind of sanity-check wrapper around
epoll_wait() calls, and match the output with what the app asked for.
If epoll starts returning messages that it doesn't want, the only
alternative is to get heavy-handed and try to get epoll to shut up with
EPOLL_CTL_DEL on the file descriptor. But this seems like fighting
against the OS.

Perhaps it should only OR the user event with POLLHUP|POLLERR if
POLLIN or POLLOUT is set?


Ben


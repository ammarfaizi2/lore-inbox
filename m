Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUEYXzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUEYXzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUEYXzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:55:45 -0400
Received: from avtrex.com ([216.102.217.178]:13541 "EHLO avtrex.com")
	by vger.kernel.org with ESMTP id S265268AbUEYXzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:55:35 -0400
Message-ID: <40B3DCCC.5040401@avtrex.com>
Date: Tue, 25 May 2004 16:54:52 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: -NODEV vs. -ENODEV
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2004 23:54:50.0329 (UTC) FILETIME=[AAAD7490:01C442B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working on a driver that is not part of the  standard kernel 
sources, I found that dev_open() was returning -NODEV when there was no 
device (instead of -ENODEV).

Since NODEV is #defined to be 0 this caused open to erroneously report 
success.

It seems to me that any place you see -NODEV in the kernel sources is 
almost certainly an error.

Using the 2.4.25 sources from linux-mips.org I get the following:

$ grep -r -- -NODEV *
drivers/isdn/sc/command.c:      return -NODEV;
drivers/media/video/cpia.c:                     return -NODEV;
drivers/net/defxx.c:    int rc = -NODEV;

I have no idea if these still exist in the current sources,  but I 
suspect that they do.

David Daney



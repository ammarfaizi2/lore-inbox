Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbUK3U4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbUK3U4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUK3U4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:56:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2468 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262314AbUK3U42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:56:28 -0500
Date: Tue, 30 Nov 2004 21:56:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Misleading error message
In-Reply-To: <001101c4d715$25a59470$af00a8c0@BEBEL>
Message-ID: <Pine.LNX.4.53.0411302151160.31175@yvahk01.tjqt.qr>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I compiled built-in support for iptables in my new 2.6.9 kernel, but when my
>legacy firewall does a "modprobe ip_tables" , I get the startling message:
>"FATAL: module ip_tables not found" .
k

Linux Developers,

what would you think of say, a line added to modules' code that identifies
compiled-in components?
modprobe could then be adjusted to
1. try loading something.ko
2. looking for a component "something" within the compiled-in stuff

I'd imagine a module's init could look like:

int __init init_module(void) {
	...
	register_static_module("ip_tables");
	...
}

Or using some linker magic to generate a table/array full with strings to
indicate their presence. (I though of kstrtab, which is, to my knowledge, also
composed of multiple single symbols into one.)

Awaiting list feedback.




>A message like "Module ip_tables not needed; support already built in the
>kernel" would be much more helpfull, as I see it.

modprobe should just return 0 as is with the case for already-loaded modules.



Jan Engelhardt
-- 
ENOSPC

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271378AbTHDF1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271379AbTHDF1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:27:32 -0400
Received: from [203.53.213.67] ([203.53.213.67]:37903 "EHLO exchange.world.net")
	by vger.kernel.org with ESMTP id S271378AbTHDF1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:27:31 -0400
Message-ID: <6416776FCC55D511BC4E0090274EFEF5080024A9@exchange.world.net>
From: Steven Micallef <steven.micallef@world.net>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: chroot() breaks syslog() ?
Date: Mon, 4 Aug 2003 15:27:27 +1000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've stumbled onto what seems to have broken somewhere between 2.4.8 and
2.4.18 (sorry, I've been unable to test it on a later version just yet).
Basically, when using chroot(), syslog() calls don't work.

The following simple example is broken on 2.4.18:

#include    <stdio.h>
#include    <sys/syslog.h>

int main(void) {
    chroot("/home/steve");
    syslog(LOG_ALERT, "TEST");
}

An strace reveals the following:

connect(3, {sin_family=AF_UNIX, path="/dev/log"}, 16) = -1 ENOENT (No such
file or directory)

Is this intentional? If so, is there a work-around? I discovered this when
debugging 'rwhod', but I imagine there are many more utils that would be
affected too.

Cheers,

Steve Micallef

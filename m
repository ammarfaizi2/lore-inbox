Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWIYVoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWIYVoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWIYVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:44:38 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22750 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751474AbWIYVoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:44:37 -0400
From: Junio C Hamano <junkio@cox.net>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Make kernel -dirty naming optional
References: <20060922120210.GA957@slug>
	<20060922104933.GA3348@harddisk-recovery.com>
	<20060924090743.GB22731@uranus.ravnborg.org>
	<20060924101155.GB9271@harddisk-recovery.nl>
cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 25 Sep 2006 14:44:36 -0700
In-Reply-To: <20060924101155.GB9271@harddisk-recovery.nl> (Erik Mouw's message
	of "Sun, 24 Sep 2006 12:11:55 +0200")
Message-ID: <7vy7s7y62j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> make mrproper
> cp ../config-2.6 .config
> yes no | make oldconfig
> fakeroot make targz-pkg

fakeroot makes the working tree files appear to be owned by
root.root but does not know git uses the file ownership
information recorded in the index and uses it to detect if the
working tree is dirty.  Because the index says they are owned by
you (the one who pulled from the kernel.org and owns the files
in the real world not fakeroot world), you get -dirty suffix.

Perhaps "fakeroot -u" would help.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUGWKEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUGWKEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUGWKEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:04:13 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:25548 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267582AbUGWKBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:01:06 -0400
Date: Fri, 23 Jul 2004 11:01:07 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
In-Reply-To: <200407222204.46799.rob@landley.net>
Message-ID: <Pine.HPX.4.58L.0407231058420.12978@punch.eng.cam.ac.uk>
References: <200407222204.46799.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, Rob Landley wrote:

> I just saw a funky thing.  Here's the cut and past from the xterm...
>
> [root@(none) root]# ps ax | grep hack
>  9964 pts/1    R      0:00 grep hack HOSTNAME= SHELL=/bin/bash TERM=xterm HISTSIZE=1000 USER=root LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=
> [root@(none) root]# ps ax | grep hack
>  9966 pts/1    S      0:00 grep hack
>
> Seems like some kind of race condition, dunno if it's in Fedore Core 1's ps
> or the 2.6.7 kernel or what...

The race is in the shell's pipeline - the processes don't start at exactly
the same time, and sometimes ps has completed before the shell has
started grep. This is the expected behaviour.

Peter

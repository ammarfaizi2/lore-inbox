Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTD1BX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTD1BX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:23:29 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:56527 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263011AbTD1BX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:23:28 -0400
Date: Sun, 27 Apr 2003 18:35:41 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Mark Grosberg <mark@nolab.conman.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <Pine.LNX.4.53.0304271831250.8792@twinlark.arctic.org>
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Mark Grosberg wrote:

> I would think on large, multi-user systems that are spawning processes all
> day, this might improve performance if the shells on such a system were
> patched.

more relevant is a large multithreaded (or async model with many
connections per thread/process) webserver spawning cgi.  otherwise you pay
the costs of duplicating the mm and even if you use F_CLOEXEC (which has a
cost-per-connection) you have to pay for scanning the open fds.

if you look at such webservers they tend to have a separate process just
for the purpose of spawning cgi/etc. and use some IPC to pass the data to
the cgi spawner.

-dean

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVJCViG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVJCViG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVJCViG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:38:06 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:59265 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932365AbVJCViF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:38:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Date: Mon, 3 Oct 2005 23:39:07 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
References: <20051002231332.GA2769@elf.ucw.cz>
In-Reply-To: <20051002231332.GA2769@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510032339.08217.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 3 of October 2005 01:13, Pavel Machek wrote:
> Split swsusp.c into swsusp.c and snapshot.c. Snapshot only cares
> provides system snapshot/restore functionality, while swsusp.c will
> provide disk i/o. It should enable untangling of the code in future;
> swsusp.c parts can mostly be done in userspace.
> 
> No code changes.

I think that the functions:

read_suspend_image()
read_pagedir()
swsusp_pagedir_relocate() (BTW, why there's "swsusp_"?)
check_pagedir() (BTW, misleading name)
data_read()
eat_page()
get_usable_page()
free_eaten_memory()

should be moved to snapshot.c as well, because they are in fact
symmetrical to what's there (they perform the reverse of creating
the snapshot and use analogous data structures).  IMO the code
change required would not be so drammatic and all of the functions
that _operate_ on the snapshot would be in the same file.

Greetings,
Rafael

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFJWYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFJWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:24:46 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:28555 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S261414AbTFJWYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:24:45 -0400
Subject: Re: [PATCH] sparse type checking on function pointers
From: Steven Cole <elenstev@mesatop.com>
To: Dave Olien <dmo@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030610212404.GA25410@osdl.org>
References: <20030610212404.GA25410@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055284400.2269.56.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Jun 2003 16:33:20 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 15:24, Dave Olien wrote:
> This patch fixes type checking on function arguments that are pointers
> to functions.  Below is an example.
> 
That reduced the number of that kind of warning significantly.

[steven@spc1 testing-2.5]$ grep "different base types" build4 | grep "in argument" | wc -l
     37
[steven@spc1 testing-2.5]$ grep "different base types" build5 | grep "in argument" | wc -l
      4
[steven@spc1 testing-2.5]$ grep "different base types" build5 | grep "in argument"
warning: include/linux/mpage.h:24:40: incorrect type in argument 3 (different base types)
warning: include/linux/mpage.h:24:40: incorrect type in argument 3 (different base types)
warning: drivers/ide/ide.c:1872:26: incorrect type in argument 2 (different base types)
warning: drivers/ide/ide.c:1947:25: incorrect type in argument 2 (different base types)

Now, if only Linus would change this:

CHECK           = /home/torvalds/parser/check

to something more reasonable like

CHECK           = /usr/local/bin/check

Steven



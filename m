Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTEaDog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 23:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTEaDog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 23:44:36 -0400
Received: from almesberger.net ([63.105.73.239]:4 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id S264134AbTEaDof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 23:44:35 -0400
Date: Sat, 31 May 2003 00:57:51 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Carl Spalletta <cspalletta@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cute kernel trick, or communistic ploy?
Message-ID: <20030531005751.A8250@almesberger.net>
References: <20030530231231.64427.qmail@web41501.mail.yahoo.com> <20030530223355.A3639@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530223355.A3639@almesberger.net>; from wa@almesberger.net on Fri, May 30, 2003 at 10:33:55PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> (I shouldn't need to kmalloc $data or the casts in kfree.
> Two more things to fix ...)

Ancient history. With the current version
http://umlsim.sourceforge.net/umlsim-37.tar.gz
it can be written as

#define GFP_ATOMIC 0x20
$uml = $run_uml("A","no-such-script",1);
$page = (char *) kmalloc(4096,GFP_ATOMIC);
$start = (char **) kmalloc(4,GFP_ATOMIC);
$eof = (int *) kmalloc(4,GFP_ATOMIC);
uptime_read_proc($page,$start,0,0,$eof,0);
kfree($eof);
printk(*$start);
kfree($start);
kfree($page);

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

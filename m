Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUCCUeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUCCUeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:34:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:8913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbUCCUeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:34:07 -0500
Date: Wed, 3 Mar 2004 12:34:06 -0800
From: Chris Wright <chrisw@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: kbuild will remove .c files
Message-ID: <20040303123406.G21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added a new config to my kernel, and hadn't done a bk -r get in quite
a while.  Turns out the subdir relevant to the config item hits the make
builtin to get the file (since it had been missing), but then kbuild
assembles, links, links, and finally removes the .c file.  This will
be done everytime, since the .c file is now gone.  While a preemptive
bk -r get is the obvious solution here (or even a after the fact bk get
$missing.c), is this a possible very small buglet in kbuild?

Here's some relevant output:

get   net/irda/irlan/SCCS/s.irlan_client.c
net/irda/irlan/irlan_client.c 1.8: 565 lines
  CC      net/irda/irlan/irlan_client.s
as   -o net/irda/irlan/irlan_client.o net/irda/irlan/irlan_client.s
  LD      net/irda/irlan/irlan.o
  LD      net/irda/irlan/built-in.o
rm net/irda/irlan/irlan_client.c

And only the net/irda/irlan/.irlan_client.s.cmd is created.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

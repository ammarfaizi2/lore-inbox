Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWAPMQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAPMQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWAPMQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:16:16 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:18738 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750735AbWAPMQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:16:15 -0500
Date: Mon, 16 Jan 2006 21:16:11 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] changes about Call Trace:
Message-ID: <20060116121611.GA539@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I realized two things when I was porting my small script oops2line
to x86-64. (read call trace, find correspondance modules, calculate addr
and addr2line)

If I'm missing something, please let me know.

a) On x86-64 we get different Call Trace format than other architectures
   when we get oops or press SysRq-t:

   <ffffffffa008ef6c>{:jbd:kjournald+1030}

   There is a architecture independent function print_symbol().
   How about using it on x86-64? But it changes to:

   [<ffffffffa008ef6c>] kjournald+0x406/0x578 [jbd]

b) I can't find useful usage for the symbol size in print_symbol().
   And symbolsize seems to be fixed when vmlinux or modules are compiled.
   So we can calculate it from vmlinux or modules.
   How about removing the field of symbolsize in print_symbol()?

   [<ffffffffa008ef6c>] kjournald+0x406 [jbd]


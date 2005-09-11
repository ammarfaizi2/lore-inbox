Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVIKN6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVIKN6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 09:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVIKN6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 09:58:13 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:22061 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932215AbVIKN6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 09:58:12 -0400
Date: Sun, 11 Sep 2005 16:00:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCHES] final kbuild update before fix-only period
Message-ID: <20050911140001.GA7544@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org> <200509111526.58010.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509111526.58010.vda@ilport.com.ua>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Sam,
> 
> BUG()s etc which are using __FILE__ to get source filename
> print horribly long names like
> 
> /.share/usr/src2/kernel/linux-2.6.13-mm2.src/drivers/net/.../some.c
> 
> if one builds kernel in separate object dir.
> This is ugly and wastes space in kernel image. Any ideas how to fix this?

I have once experimenting with this on request from Olaf.
The only way I could fine was to pass a new define:
-DKBUILD_FILE='short-file-name' to gcc.
This has the sideeffect that we always accuse the main .c file for
being the culprint.
gcc warns if we override __FILE__

__FILE__ is used in 123 files of wich 26 is within arch/
so it will take a while to change...

I can cook up something if there is interest.

	Sam

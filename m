Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUEXR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUEXR4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUEXR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:56:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:11750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264610AbUEXR40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:56:26 -0400
Date: Mon, 24 May 2004 10:55:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tarballs of patchsets?
Message-Id: <20040524105552.311a990b.akpm@osdl.org>
In-Reply-To: <40B21F98.1080803@g-house.de>
References: <40B21F98.1080803@g-house.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian <evil@g-house.de> wrote:
>
> i am trying to chase some bug and i know, it must be somewhere between 2.6.4 and 
>  2.6.5.

The most practical way of doing this would be to download bitkeeper and do
a binary search.


 1: Do `bk changes > foo'.

    This generates a monster changelog file which is your
    bisection-searching guide.  It has stuff like:

 ChangeSet@1.1734, 2004-05-21 22:59:48+01:00, tony@com.rmk.(none)
   [ARM PATCH] 1887/1: Update OMAP low level debug functions again
   
   Patch from Tony Lindgren
   
   This patch makes the low level debug functions work when support is
   compiled in for multiple OMAPs. The patch also removes now unnecessary
   include, incorrect comment, and SERIAL_REG_SHIFT ifdefs.


 2: Do

 	bl clone -ql -r1.1734 ref-repo test-repo

    and you have a tree up to and including 1.1734.

 3: cd test-repo ; bk -r get

 4: build, test, choose new revision, goto step 1.


It's probably possible to do the same with the CVS tree - I haven't tried.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbTHCQzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 12:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270255AbTHCQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 12:55:39 -0400
Received: from waste.org ([209.173.204.2]:29317 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270040AbTHCQzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 12:55:39 -0400
Date: Sun, 3 Aug 2003 11:55:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Heikki Tuuri <Heikki.Tuuri@innodb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-ID: <20030803165522.GS22824@waste.org>
References: <009201c3599f$04ff05c0$322bde50@koticompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009201c3599f$04ff05c0$322bde50@koticompaq>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 12:10:01PM +0300, Heikki Tuuri wrote:
> 
> What to do? People who write drivers should run heavy, multithreaded file
> i/o tests on their computer using some SQL database which calls fsync(). For
> example, run the Perl '/sql-bench/innotest's all concurrently on MySQL. If
> the problems are in drivers, that could help.

Did you know that until test2-mm3, nothing would report errors that
occurred on non-synchronous writes? There was no infrastructure to
propagate the error back to userspace. If you wrote a page, the write
failed on an intermittent I/O error, and then read again, you'd
silently get back the old page.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

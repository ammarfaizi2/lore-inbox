Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265633AbUFTOjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUFTOjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUFTOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:39:46 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:28146 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265633AbUFTOje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:39:34 -0400
Subject: RE: [PATCH] Handle non-readable binfmt misc executables
From: Albert Cahalan <albert@users.sf.net>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <2C83850C013A2540861D03054B478C060416BC0E@hasmsx403.ger.corp.intel.com>
References: <2C83850C013A2540861D03054B478C060416BC0E@hasmsx403.ger.corp.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1087733836.9831.965.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2004 08:17:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-20 at 06:36, Zach, Yoav wrote:
> Albert,
> I'm a little bit confused - I see myself in the CC: list, with no
> recipient in the To: list. I'm not sure this reply will get to all
> the recipients of your message. Will you please forward it to all
> the rest ?

I don't know if I did send it elsewhere. Maybe I had
intended to add linux-kernel.

> Anyways, the problem with the info in /proc can be solved by
> the translator itself in userland. The way it is done in the IA-32
> Execution Layer is by shifting the arguments vector two positions to
> the left, so the user can see the original argument list without the
> additional information the kernel uses for the binfmt_misc mechanism.

So the content of /proc/*/cmdline is correct?

At a minimum, you will have a problem at startup.
The process might be observed before you fix argv.

What about apps that walk off the end of argv to get
at the environment?

It seems cleaner to use some other mechanism.
Assuming your interpreter is ELF, ELF notes are good.
You might use prctl().



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUI1QCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUI1QCL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUI1QCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:02:11 -0400
Received: from zeus.kernel.org ([204.152.189.113]:43432 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267953AbUI1QCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:02:04 -0400
Date: Tue, 28 Sep 2004 09:00:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Roland Dreier <roland@topspin.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Message-Id: <20040928090032.292d12e8.pj@sgi.com>
In-Reply-To: <52mzzacsyk.fsf@topspin.com>
References: <1096302710971@topspin.com>
	<10963027102899@topspin.com>
	<20040927131014.695b8212.pj@sgi.com>
	<52fz53e526.fsf@topspin.com>
	<20040927234333.7cceff47.pj@sgi.com>
	<52mzzacsyk.fsf@topspin.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the next env var is going to be concatenated with this one.

Right you are - unlike most times where one is trying to concatenate
strings, this time you want the nul char separator.

> It's precisely this sort of easy-to-make off-by-one bug that convinces
> me the hotplug environment variable handling needs to be wrapped up in
> a helper macro or function.

Perhaps - but perhaps also I've shown you ways to use a function with
fewer non-const variables.

And perhaps the placing of the nul chars should be explicit:

	if (length < buffer_size)
		buffer[length++] = '\0';

so that someone else doesn't either miss the intentional inclusion of
the nul as I just did, or does see it and thinks it's an off-by-one
error and "fixes" it.

That macro was ugly.

Adding to my previous rules of:
  * minimum number variables
  * simplest invariants on variables
  * functions beat macros
now include:
  * explicit coding of anything out of the ordinary.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

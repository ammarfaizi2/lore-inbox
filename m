Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWB0UwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWB0UwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWB0UwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:52:07 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32392 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S964823AbWB0UwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:52:04 -0500
Message-ID: <44036670.7060204@namesys.com>
Date: Mon, 27 Feb 2006 12:52:00 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Marr <marr@flex.com>,
       reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <200602261407.33262.ioe-lkml@rameria.de> <4401B233.7050308@yahoo.com.au>
In-Reply-To: <4401B233.7050308@yahoo.com.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like the real problem is that glibc is doing filesystem
optimizations without making them conditional on the filesystem type. 
Does anyone know the email address of the glibc guy so we can ask him
not to do that?

My entry for the ugliest thought of the day: I wonder if the kernel can
test the glibc version and.....

Hans

Nick Piggin wrote:

>
> Actually glibc tries to turn this pre-read off if the seek is to a page
> aligned offset, presumably to handle this case. However a big write
> would only have to RMW the first and last partial pages, so pre-reading
> 128KB in this case is wrong.
>
> And I would also say a 4K read is wrong as well, because a big read will
> be less efficient due to the extra syscall and small IO.
>


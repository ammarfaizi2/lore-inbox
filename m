Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVAELlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVAELlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVAELlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:41:36 -0500
Received: from [194.230.129.26] ([194.230.129.26]:47410 "EHLO wine.dyndns.org")
	by vger.kernel.org with ESMTP id S262344AbVAELlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:41:13 -0500
To: Mike Hearn <mh@codeweavers.com>
Cc: Thomas Sailer <sailer@scs.ch>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, wine-devel@winehq.com,
       mingo@elte.hu
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	<200412311413.16313.sailer@scs.ch>
	<1104499860.3594.5.camel@littlegreen>
	<200412311651.12516.sailer@scs.ch>
	<1104873315.3557.87.camel@littlegreen>
From: Alexandre Julliard <julliard@winehq.org>
Date: 05 Jan 2005 12:40:33 +0100
In-Reply-To: <1104873315.3557.87.camel@littlegreen>
Message-ID: <874qhwje8e.fsf@wine.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn <mh@codeweavers.com> writes:

> - Another possibility would be to create a new mmap API that lets
>   us ask for exactly what we want, instead of second-guessing the
>   kernel. I don't know exactly what sort of an API Alexandre has in
>   mind here, perhaps he could describe it.

Probably the easiest would be to have a way for an app to specify the
mmap range it wants. So instead of having the kernel try to guess from
brk and stack ulimit, both of which are meaningless for Win32 apps, we
could set the range from "end of win32 exe" to 0x7ff0000. This would
also avoid the need to preallocate everything above 0x80000000 that we
currently do and that plays havoc with address space limits.

-- 
Alexandre Julliard
julliard@winehq.org

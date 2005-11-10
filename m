Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVKJIXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVKJIXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVKJIXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:23:41 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:35251
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751338AbVKJIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:23:40 -0500
Message-Id: <437311D8.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 09:24:40 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Gerd Knorr" <kraxel@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make vesafb build without CONFIG_MTRR
References: <436F5C5A.76F0.0078.0@novell.com> <20051109215934.GD4047@stusta.de>
In-Reply-To: <20051109215934.GD4047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Adrian Bunk <bunk@stusta.de> 09.11.05 22:59:35 >>>
>On Mon, Nov 07, 2005 at 01:53:30PM +0100, Jan Beulich wrote:
>
>> vesafb did not build without CONFIG_MTRR.
>>...
>
>I wasn't able to reproduce your problem.
>
>Please send the error message and the a complete .config for
reproducing 
>it.

Hmm, yes. The change came from the Xen kernel, which for some reason
has CONFIG_MTRR but doesn't compile the respective source file on
x86-64. When I ran into that, I didn't realize that include/asm/mtrr.h
has wrappers for the !CONFIG_MTRR case.

But anyway, the code now framed by the conditionals is dead code
without CONFIG_MTRR anyway. So if the number of #ifdef-s is important
I'm OK with withrawing that patch, but then I'd like to see the same
happen in all the other frame buffer drivers (after all it was the fact
that the conditionals were there everywhere else I checked that made me
not look at include/asm/mtrr.h)...

Jan

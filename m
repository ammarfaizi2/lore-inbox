Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVA2IJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVA2IJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVA2IJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:09:29 -0500
Received: from one.firstfloor.org ([213.235.205.2]:18146 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262877AbVA2IIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:08:16 -0500
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 Jan 2005 09:08:14 +0100
In-Reply-To: <16890.38062.477373.644205@tut.ibm.com> (Tom Zanussi's message
 of "Fri, 28 Jan 2005 13:38:22 -0600")
Message-ID: <m1d5volksx.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi <zanussi@us.ibm.com> writes:

> Hi,
>
> This patch is the result of the latest round of liposuction on relayfs
> - the patch size is now 44K, down from 110K and the 200K before that.
> I'm posting it as a patch against 2.6.10 rather than -mm in order to
> make it easier to review, but will create one for -mm once the changes
> have settled down.

The logging fast path seems still a bit slow to me. I would like
to have a logging macro that is not much worse than a stdio putc,
basically something like

          get_cpu();
          if (buffer space > N) { 
              memcpy(buffer, input, N);
              buffer pointer += N;
          } else { 
              FreeBuffer(input, N); 
          }    
          put_cpu();

This would need interrupt protection only if interrupts can access
it, best you use separate buffers for that too.

-Andi

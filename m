Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318192AbSGQCFY>; Tue, 16 Jul 2002 22:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSGQCFX>; Tue, 16 Jul 2002 22:05:23 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:60316 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318192AbSGQCFW>; Tue, 16 Jul 2002 22:05:22 -0400
Date: Tue, 16 Jul 2002 19:08:14 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>,
       GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Add sys/personality (Re: Personality)
Message-ID: <20020716190814.A31309@lucon.org>
References: <3D33DAB2.353A4399@mips.com> <20020716123632.B17038@dea.linux-mips.net> <20020716090728.A22128@lucon.org> <3D347120.B9CAFF75@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D347120.B9CAFF75@mips.com>; from carstenl@mips.com on Tue, Jul 16, 2002 at 09:16:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 09:16:48PM +0200, Carsten Langgaard wrote:
> Thanks.
> Now that we are at it, what should personality return in case it's called with a
> value, which isn't defined in the personality.h file.
> Should it return -EINVAL ?
> I don't think, that is the case at the moment, I believe you can set personality
> to anything.
> 

Like this?


H.J.
---
--- kernel/exec_domain.c.per	Mon Jun 10 10:05:27 2002
+++ kernel/exec_domain.c	Tue Jul 16 19:06:13 2002
@@ -223,7 +223,8 @@ sys_personality(u_long personality)
 
 	if (personality != 0xffffffff) {
 		set_personality(personality);
-		if (current->personality != personality)
+		if (personality < current->exec_domain->pers_low
+		    || personality > current->exec_domain->pers_high)
 			return -EINVAL;
 	}
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUGOPsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUGOPsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUGOPsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:48:14 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:15779 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S266220AbUGOPsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:48:07 -0400
Message-ID: <40F6A603.80503@torque.net>
Date: Thu, 15 Jul 2004 11:42:59 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, mikpe@csd.uu.se,
       B.Zolnierkiewicz@elka.pw.edu.pl, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141751.i6EHprhf009045@harpo.it.uu.se>	<40F57D14.9030005@pobox.com> <20040714143508.3dc25d58.akpm@osdl.org>
In-Reply-To: <20040714143508.3dc25d58.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Or you could just call it "gcc is dumb" rather than a compiler bug.
> 
> 
> Yeah, but doing:
> 
> 	static inline foo(void);
> 
> 	bar()
> 	{
> 		...
> 		foo();
> 	}
> 
> 	static inline foo(void)
> 	{
> 		...
> 	}
> 
> is pretty dumb too.  I don't see any harm if this compiler feature/problem
> pushes us to fix the above in the obvious way.

It might be dumb but C99 (ISO/IEC 9899:1999(E) ) says in
section 6.7.4 :
   "function-specifiers shall be used only in the
    declaration of an identifier for a function"

The only "function-specifier" defined in C99 is
"inline". So that seems to imply "inline" should
not appear in a function definition. If that is true
then you must declare an inline function before use
in order to pass the "inline" hint to the compiler.

Anyways C99 says very little about "inline" other than
some restrictions on its usage together with external
linkage. That seems to imply constructs that are legal
_without_ "inline" in front of a function declaration
should also be legal when "inline" is added (modulo
external linkage restrictions).

Doug Gilbert


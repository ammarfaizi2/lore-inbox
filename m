Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTA1Fr0>; Tue, 28 Jan 2003 00:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA1Fr0>; Tue, 28 Jan 2003 00:47:26 -0500
Received: from dp.samba.org ([66.70.73.150]:65447 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264844AbTA1FrY>;
	Tue, 28 Jan 2003 00:47:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: return-type for search_extable() 
In-reply-to: Your message of "Fri, 24 Jan 2003 10:23:31 -0800."
             <15921.33955.645830.709868@napali.hpl.hp.com> 
Date: Tue, 28 Jan 2003 15:53:20 +1100
Message-Id: <20030128055643.BCB282C236@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15921.33955.645830.709868@napali.hpl.hp.com> you write:
> Hi Rusty,
> 
> Could you please change the return-type of search_extable() to
> something that allows a bit more flexibility?  The value returned by
> this function is "something that lets architecture-specific code
> recover from a memory-managment-fault".  This may or may not be the
> same as an exception_table_entry.  For example, on ia64, I want to
> return an already-relocated fixup-word.  Perhaps the cleanest way to
> fix this would be to have:
> 
> 	exception_fixup_t search_extable (...);
> 
> By default, you could then use
> 
> 	typedef struct exception_table_entry *exception_fixup_t;
> 
> and on ia64 I could use:
> 
> 	typedef long exception_fixup_t.

Sure.  Of course, you could just cast the return value to a long
inside ia64, but that's pretty unclear.

Hmm, I actually just tried to do this, and like all typedefs, it's
icky.  search_exception_table() belongs in kernel.h, not module.h
where it is now.  But that means kernel.h has to include asm/uaccess.h
to get exception_fixup_t.

Maybe the cleanest way really is to simply document that your
search_extable() returns the fixup word... 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTAXSOZ>; Fri, 24 Jan 2003 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTAXSOZ>; Fri, 24 Jan 2003 13:14:25 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:42450 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261448AbTAXSOY>;
	Fri, 24 Jan 2003 13:14:24 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15921.33955.645830.709868@napali.hpl.hp.com>
Date: Fri, 24 Jan 2003 10:23:31 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: return-type for search_extable()
In-Reply-To: <20030114025453.5ECBB2C440@lists.samba.org>
References: <Pine.GSO.3.96.1030113114240.25230B-100000@delta.ds2.pg.gda.pl>
	<20030114025453.5ECBB2C440@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

Could you please change the return-type of search_extable() to
something that allows a bit more flexibility?  The value returned by
this function is "something that lets architecture-specific code
recover from a memory-managment-fault".  This may or may not be the
same as an exception_table_entry.  For example, on ia64, I want to
return an already-relocated fixup-word.  Perhaps the cleanest way to
fix this would be to have:

	exception_fixup_t search_extable (...);

By default, you could then use

	typedef struct exception_table_entry *exception_fixup_t;

and on ia64 I could use:

	typedef long exception_fixup_t.

The only restriction on exception_fixup_t would be that it's a type
that can be tested for being equal to zero and, if it is zero, it
would mean that there is no exception-table entry.

Alternatively, we could make search_extable() just always return a
"void *" or a "long", but that's less clear and less type-safe.

	--david

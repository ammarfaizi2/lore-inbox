Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266448AbUGJVxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUGJVxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUGJVxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:53:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43136 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266448AbUGJVxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:53:50 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Paul Jackson <pj@sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, chrisw@osdl.org,
       sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mika@osdl.org, akpm@osdl.org, jmorris@redhat.com
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<20040709164919.6b6a077d.pj@sgi.com>
	<849F7707-D212-11D8-8B07-000393ACC76E@mac.com>
	<20040710014740.GA11477@gondor.apana.org.au>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 18:53:12 -0300
In-Reply-To: <20040710014740.GA11477@gondor.apana.org.au>
Message-ID: <orllhro7g7.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  9, 2004, Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jul 09, 2004 at 09:43:18PM -0400, Kyle Moffett wrote:
>> 
>> most clear?  These are all "logically" correct, for the most part, but
>> as humans we have certain readability standards.

> Nope, B is undefined.

Nope, B is implementation-defined.  The conversion from pointers to
integers is implementation-defined, and it's meant to be unsurprising
to those familiar with the architecture.  I.e., if you can
zero-initialize a pointer and get a NULL pointer back, it's quite
likely that a NULL pointer will convert back to (int)0, even though
it's not required by the C Standard AFAICT.

>> int some_function(int a, void *b, char *c, unsigned char d, int e);

>> B)	int res = some_function(NULL,NULL,NULL,NULL,NULL);

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

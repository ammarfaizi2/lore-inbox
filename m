Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUGJWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUGJWHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 18:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUGJWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 18:07:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44420 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266451AbUGJWHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 18:07:11 -0400
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<40EFB775.8020408@eyal.emu.id.au>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 19:07:01 -0300
In-Reply-To: <40EFB775.8020408@eyal.emu.id.au>
Message-ID: <ord633o6t6.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 10, 2004, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

> Very much yes. I will go further and say that only boolean
> variables should use the above syntax. Using
> 	if (i)
> where 'i' is a non-boolean integer instead of
> 	if (0 != i)
> makes me question what the programmer wanted. Since integers
> do not have clear names for true/false logic (booleans usually
> will be called something like 'have_brain" etc.) the simple
> 'if (i)' may just as well be a miswritten 'if (!i)' - and I
> caught a few of these bugs in my time.

So how about pushing for writing (i == 1) if i is boolean, to be
clearer?  It's often nice to be able to tell whether a boolean
variable is strict 0/1 or just zero/non-zero, when you're thinking of
switching to 3+-state logic.  But guess what, i == 1 is far less
efficient than i != 0 on many architectures.  It's an unfortunate
trade-off you have to make in this case.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

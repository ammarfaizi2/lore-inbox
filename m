Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSFULNL>; Fri, 21 Jun 2002 07:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSFULNK>; Fri, 21 Jun 2002 07:13:10 -0400
Received: from pat.uio.no ([129.240.130.16]:43150 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316542AbSFULNJ>;
	Fri, 21 Jun 2002 07:13:09 -0400
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] (resend) credentials for 2.5.23
References: <20020619212909.A3468@redhat.com> <1024540235.917.127.camel@sinai>
	<20020620122858.B4674@redhat.com> <1024593066.922.149.camel@sinai>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1024593066.922.149.camel@sinai>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
Date: 21 Jun 2002 13:12:59 +0200
Message-ID: <shs4rfwx4uc.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Robert Love <rml@tech9.net> writes:

     > CLONE_CRED.  I suspect 90% of the cases retain the same
     > credentials anyhow.  Copy-on-write? :)

Ben,

  Making the credentials a monolithic block like you appear to be
doing just doesn't make sense. If you look at the way things like
fsuid/fsgid/groups[] are used, you will see that almost all those that
filesystems that care are making their own private copies.

  It would be a lot more useful to split out fsuid/fsgid/groups[] as
per the *BSD ucred, and then allow filesystems to reference the
resulting struct instead (using COW semantics).

That way too, 'struct file' could finally contain a reference to a
full copy of the filesystem credentials, and we could get rid of
the 'struct file' crud in address_space_operations like readpage().

See
  http://www.fys.uio.no/~trondmy/src/bsdcred/linux-2.5.1-pre11_cred.dif

for my earlier attempt at doing this sort of thing...

Cheers,
  Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUFOXvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUFOXvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUFOXvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:51:53 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:3575 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S266021AbUFOXvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:51:47 -0400
In-Reply-To: <20040615150707.B22989@build.pdx.osdl.net>
References: <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com> <3943FF92-BEFE-11D8-95EB-000393ACC76E@mac.com> <20040615150707.B22989@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <880FEF02-BF26-11D8-95EB-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Blair Strang <bls@asterisk.co.nz>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Tue, 15 Jun 2004 19:48:41 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15, 2004, at 18:07, Chris Wright wrote:
> * Kyle Moffett (mrmacman_g4@mac.com) wrote:
>> One thing that I would very much like to have is the ability to create
>> a new
>> shell with a new keyring, such that I can still see and use the old
>> keyring,
>> but I can create new keys without modifying the old keyring, even to 
>> the
>> extent of masking out keys in the old keyring without modifying them 
>> for
>> other processes.  From my brief glance at your patch, that's not a
>> feature you have implemented.
> Sounds like a CLONE_KEYRING flag?

I think the two concepts are unrelated.  You should not be required
to create a new thread/process/task in order to give yourself a
separate key-ring, and it would be plain stupid to have one mode
of the clone() syscall that doesn't create a new task but instead
changes key-rings  Take Apache and suexec PHP  for example: it
would be very useful to be able to have a key-ring owned by the
root user  that contains the AFS keys Apache uses to access files.
Then when it runs a suexec PHP script, it adds a new key-ring
owned by "someuser" to the process (without doing a clone()).
It does a seteuid("someuser"), then proceeds with the PHP code.
That gives the user's PHP its own key-ring context, and protects
the parent's key-ring.  When done it removes "someuser"'s keys
and does seteuid(0).

Cheers,
Kyle Moffett


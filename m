Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVCVUsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVCVUsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVCVUp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:45:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:48821 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261759AbVCVUoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:44:14 -0500
Date: Tue, 22 Mar 2005 21:46:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Howells <dhowells@redhat.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Vance <cvance@nai.com>,
       Wayne Salamon <wsalamon@nai.com>, James Morris <jmorris@redhat.com>,
       dgoeddel@trustedcs.com, Karl MacMillan <kmacmillan@tresys.com>,
       Frank Mayer <mayerf@tresys.com>, selinux@tycho.nsa.gov,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree()
 in security/ 
In-Reply-To: <9581.1111505666@redhat.com>
Message-ID: <Pine.LNX.4.62.0503222141540.2683@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost>
  <9581.1111505666@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, David Howells wrote:

> 
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> > --- linux-2.6.11-mm4-orig/security/keys/key.c	2005-03-16 15:45:42.000000000 +0100
> > +++ linux-2.6.11-mm4/security/keys/key.c	2005-03-20 12:40:19.000000000 +0100
> > ...
> > -	if (candidate)
> > -		kfree(candidate);
> > +	kfree(candidate);
> 
> Looks okay to me. It's probably less efficient though, but more space
> efficient.
> 
>From looking at the code gcc generates it looks to me like the bennefits
of the smaller code should outweigh the overhead of a few more function
calls - especially if the branch is usually taken (which I must admit I 
can't really tell if it will be). If the branch is rarely taken you are 
probably right.


> > --- linux-2.6.11-mm4-orig/security/keys/user_defined.c	2005-03-16 15:45:42.000000000 +0100
> > +++ linux-2.6.11-mm4/security/keys/user_defined.c	2005-03-20 12:41:54.000000000 +0100
> > @@ -182,9 +182,7 @@ static int user_match(const struct key *
> >   */
> >  static void user_destroy(struct key *key)
> >  {
> > -	struct user_key_payload *upayload = key->payload.data;
> > -
> > -	kfree(upayload);
> > +	kfree(key->payload.data);
> 
> There's a patch in Andrew Morton's tree that changes this to make use of RCU,
> so I'd prefer you didn't do this just yet.
> 
Huh? I just checked 2.6.12-rc1-mm1, and the user_destroy function still 
looks as above...  But no problem, I'll just send Andrew the bits in 
security/selinux/ for now and wait a bit with the rest. 

Thank you for your comments.


-- 
Jesper 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVCVPjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVCVPjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVCVPje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:39:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261303AbVCVPet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:34:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost> 
References: <Pine.LNX.4.62.0503201316270.2501@dragon.hyggekrogen.localhost> 
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Vance <cvance@nai.com>,
       Wayne Salamon <wsalamon@nai.com>, James Morris <jmorris@redhat.com>,
       dgoeddel@trustedcs.com, Karl MacMillan <kmacmillan@tresys.com>,
       Frank Mayer <mayerf@tresys.com>, selinux@tycho.nsa.gov,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] don't do pointless NULL checks and casts before kfree() in security/ 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 22 Mar 2005 15:34:26 +0000
Message-ID: <9581.1111505666@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper Juhl <juhl-lkml@dif.dk> wrote:

> --- linux-2.6.11-mm4-orig/security/keys/key.c	2005-03-16 15:45:42.000000000 +0100
> +++ linux-2.6.11-mm4/security/keys/key.c	2005-03-20 12:40:19.000000000 +0100
> ...
> -	if (candidate)
> -		kfree(candidate);
> +	kfree(candidate);

Looks okay to me. It's probably less efficient though, but more space
efficient.

> --- linux-2.6.11-mm4-orig/security/keys/user_defined.c	2005-03-16 15:45:42.000000000 +0100
> +++ linux-2.6.11-mm4/security/keys/user_defined.c	2005-03-20 12:41:54.000000000 +0100
> @@ -182,9 +182,7 @@ static int user_match(const struct key *
>   */
>  static void user_destroy(struct key *key)
>  {
> -	struct user_key_payload *upayload = key->payload.data;
> -
> -	kfree(upayload);
> +	kfree(key->payload.data);

There's a patch in Andrew Morton's tree that changes this to make use of RCU,
so I'd prefer you didn't do this just yet.

David

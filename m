Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWDVU2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWDVU2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWDVU2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:28:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50637 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751136AbWDVU2P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:28:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ldxEjcuxZGdB81pAWKfLtscjKdJk8s6VmK+kaxGHsGHiClzYgb3yMNOBw5VHygtpLk7uF+0dE6M1R5ryQJ87B7M881J3yAinsXQSgpOvPNMdrTharjiwi5YhVYTk2ayop6Blo8ETHca2dzuuXoPeWTPRvgX4OM6YJimV0vbIr3Q=
Message-ID: <9a8748490604220434u2af03f40j12410477f11ff3bb@mail.gmail.com>
Date: Sat, 22 Apr 2006 13:34:04 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: kfree(NULL)
Cc: "Andrew Morton" <akpm@osdl.org>, "James Morris" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <17481.28892.506618.865014@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	 <Pine.LNX.4.64.0604210322110.21429@d.namei>
	 <20060421015412.49a554fa.akpm@osdl.org>
	 <17481.28892.506618.865014@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/06, Paul Mackerras <paulus@samba.org> wrote:
> Andrew Morton writes:
>
> > Yes, kfree(NULL) is supposed to be uncommon.  If someone's doing it a lot
> > then we should fix up the callers.
>
> Well, we'd have to start by fixing up the janitors that run around
> taking out the if statements in the callers.  :)
>
I think there was pretty good agreement, when we started doing that,
that taking out the if statements in the callers was a good idea.
If it turns out to have been a net loss that's not good, but I don't
think it's been a wasted effort - there were a *lot* of places that
checked for NULL before calling [kv]free, and now that we've gotten
rid of them we can consider adding them back where it makes sense, not
just all over the place.
We could also consider changing the
 if (unlikely(!obj))
 return;
in kfree into simply
 if (!obj)
 return;

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

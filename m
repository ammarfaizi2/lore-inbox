Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTEOApb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTEOApa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:45:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46344 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263319AbTEOAp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:45:26 -0400
Date: Wed, 14 May 2003 17:57:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Garance A Drosihn <drosih@rpi.edu>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
In-Reply-To: <p05210619bae885784bd4@[128.113.24.47]>
Message-ID: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Garance A Drosihn wrote:
> 
>      For any process where pag != 0, that process will share
>      tokens with all other processes that have the exact same
>      pag value as it has.  This is true even if the different
>      processes are tied to different user ids.

Yeah, and the thing I think it _totally_ and utterly broken is that there 
can be only one of these per process.

I don't see where the 1:1 idea comes from, except from a bad 
implementation.

> There is absolutely no connection between userids and PAG's,
> the same way that there is no connection between userids and
> process-numbers.  (Roughly speaking:) The 10th person to log
> in will get the 10th pag, no matter what userid they happen
> to log in as.

And this is also again nothing but the result of a bad implementation.

>From a system maintenance issue, this is a nightmare. It makes joining a 
group nigh impossible, since now the joiner (login or something) has to 
keep track of what pag's it has used for previous logins. Which is fine as 
long as you have _one_ login authority, but it's a total disaster to 
require that kind of centralization.

> It's tokens which have some relation to userids.  In the world
> of AFS, a pag can hold only one token from any one AFS cell
> at a given time.  But I can change which "AFS userid" that I
> am, without changing which pag I am in, and all processes in
> that same pag will instantly become that same "AFS userid".

Yes. And apparently PAG's - as you see them - are nothing but a AFS issue.  
As such, I think they are totally uninteresting for the core kernel, and I
will _not_ be applying any patches that introduce such a limiting and
stupid notion into the core kernel.

I'm interested in a much more generic issue of "user credentials", and 
here a PAG can be _one_ credential that a user holds on to. But to be 
useful, a user has to be able to have multiple such credentials. While one 
might be his "AFS userid", another will be his NFS mount credentials, and 
a third one will be his key to decrypt his home directory on that machine.

If it's useful for AFS only, I'm not interested. 

		Linus


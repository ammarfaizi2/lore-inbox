Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTEMTHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTEMTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:07:15 -0400
Received: from hermes.ctd.anl.gov ([130.202.113.27]:36306 "EHLO
	hermes.ctd.anl.gov") by vger.kernel.org with ESMTP id S263438AbTEMTHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:07:11 -0400
Message-ID: <3EC14538.B8692D5C@anl.gov>
Date: Tue, 13 May 2003 14:19:20 -0500
From: "Douglas E. Engert" <deengert@anl.gov>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Neulinger, Nathan" <nneul@umr.edu>
CC: David Howells <dhowells@warthog.cambridge.redhat.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@cambridge.redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
References: <B578DAA4FD40684793C953B491D4879174D3BA@umr-mail7.umr.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Neulinger, Nathan" wrote:
> 
> > > >  (2) gettok(const char *fs, const char *key, size_t size,
> > void *buffer)
> > > >
> > > >      Get a copy of an authentication token.
> > >
> > > Not sure what the use of this is for userspace. I can see how your
> > > kernel module would use it.
> >
> > OpenAFS has it, but I'm not sure what uses it.
> 
> Any afs user space tool that needs to talk to file servers - such as all
> the administration utilities - vos, bos, pts, etc. Eventually they could
> use kerberos cred caches directly, but not until they are converted to
> kerberos. Right now, they fetch the current auth data from the kernel
> and use it to authenticate to whatever non-kernel service they are
> talking to.

If the PAG was implemented well, then even the Kerberos credentials
could be contained within the PAG, or accessible only by other processes
in the same PAG. 

One way to think of the PAG is a way of getting around the limited
capabilities of UNIX to have only a UID which is only locally unique. 
The PAG identifies the user globally, and stores credentials to use
to prove it to other systems of file systems. 

Linus said in two previous note:

> I think we should make the current "tsk->user" thing _be_ the "PAG".  

and:
> A "user" is by definition what the unix filesystem considers to be the
> "atom of security".

This may well be true, but current UNIX file systems continue to use the
simple UID and GID for access. Maybe there something that can be done
here as well. 
    


> 
> -- Nathan
> _______________________________________________
> OpenAFS-devel mailing list
> OpenAFS-devel@openafs.org
> https://lists.openafs.org/mailman/listinfo/openafs-devel

-- 

 Douglas E. Engert  <DEEngert@anl.gov>
 Argonne National Laboratory
 9700 South Cass Avenue
 Argonne, Illinois  60439 
 (630) 252-5444

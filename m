Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTHVSCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTHVSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:02:47 -0400
Received: from pat.uio.no ([129.240.130.16]:57514 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263259AbTHVSCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:02:43 -0400
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       kuznet@ms2.inr.ac.ru, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow either tid or pid in SCM_CREDENTIALS struct ucred
References: <1061451559.4386.13.camel@localhost.localdomain>
	<3F464CE4.8040704@redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Aug 2003 11:02:18 -0700
In-Reply-To: <3F464CE4.8040704@redhat.com>
Message-ID: <shs4r094llh.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ulrich Drepper <drepper@redhat.com> writes:

     > I don't think ->pid should be tested.  Just replace it with
     > ->tgid.  It's really not intended for the user to have any
     > contact with the TID (i.e., ->pid).  This is how it's done in
     > other place.  What this shows is that more searches for ->pid
     > are needed which need to be replaced with ->tgid.

There's one remaining case in the NFS locking code:
nlmclnt_setlockargs() is using ->pid in order to label the lock owner.

I have a feeling that for that particular case, we'll just want to
drop the entire process-crap. The reason is that spec just says

   "The oh field is an opaque object that identifies the host or
   process that is making the request."

So as long as we're doing the lock accounting correctly on the client,
the server should be happy with just the hostname.
AFAIK, the word 'process' in the above sentence was added mainly in
order to allow userland NFS clients to push the accounting over onto
the server.

Cheers,
  Trond

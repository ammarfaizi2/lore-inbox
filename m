Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760098AbWLFFAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760098AbWLFFAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760102AbWLFFAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:00:23 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:45944 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760098AbWLFFAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:00:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=DN2AiE3pMmjfosJahVkuaLZ4UoxjzESEJF9L64oHgra1FKRB0Y8e2YvqauBZxacsXZoqdXZu+XvtPr9O+hzpUOH1BwidWRsYsOIMTAXzX3FvF9gXrfnjJmIsoTifmWVo51AgHwfLzD7vfZTuhZZSQu/rGC1i5DGLf4I1PtberuQ=;
X-YMail-OSG: NZ2YY5gVM1nXsjQC0NxpPJ2RxsWkSbFI23yFqBsaSwTFjtXvJM_ODE.IsibIaRRux5ejL09vhVHzCwHIVqrYvDQ.Gt2kLkhCeC5kQ51m02NL3XcfRZkLWgQmN5KjY9ksUabRNSuV0Wo-
Date: Tue, 5 Dec 2006 21:00:20 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: Michael Reed <mdr@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4575D951.3010705@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <794609.32071.qm@web31811.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Michael Reed <mdr@sgi.com> wrote:
> Luben Tuikov wrote:
> ...snip...
> > This statement in scsi_io_completion() causes the infinite retry loop:
> >    if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
> >          return;
> 
> The code in 2.6.19 is "result==0", not "!!result", which is logically
> the same as "result!=0".  Did you mean to change the logic here?
> Am I missing something?

Hmm, I think my trees have !!result from an earlier patch I posted.

In this case it would appear that the second chunk of the patch
wouldn't be necessary, since result==0 would be false, and it
wouldn't retry.

    Luben




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752807AbWKBKVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbWKBKVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWKBKVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:21:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:63377 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752807AbWKBKVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:21:21 -0500
X-Sasl-enc: jGpsFrJC8c6OtJO7hqtrvGkdU7I7/jN1PrqEX70PzsA/ 1162462880
Subject: Re: [BUG] 2.6.19-rc3 autofs crash on my IA64 box
From: Ian Kent <raven@themaw.net>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: "bibo,mao" <bibo.mao@intel.com>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061102183020.446D.Y-GOTO@jp.fujitsu.com>
References: <45485478.8060909@intel.com>
	 <20061102183020.446D.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 18:21:16 +0800
Message-Id: <1162462876.6980.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 18:51 +0900, Yasunori Goto wrote:
> Hello.
> 
> > hi,
> >   2.6.19-rc3 kernel crashes on my IA64 box, it seems the problem
> > of autofs fs. I debug this problem, if autofs kernel does not
> > match daemon version, it will call autofs_catatonic_mode.
> > But at that time sbi->pipe is NULL.
> > 
> > void autofs_catatonic_mode(struct autofs_sb_info *sbi)
> > {
> >    .........
> >    fput(sbi->pipe);        /* Close the pipe */
> > 	^^^^^^^^^^^^
> >  	sbi->pipe seems NULL;
> >    autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
> > }
> > 
> 
> My box crashed too.
> 
> Following fix does not seem enough.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116110204104327&w=2

I'm not surprised it addresses a completely different problem.

> If version does not match at autofs_fill_super(), then sbi->pipe
> is not set yet.
> I suppose something like following patch is necessary.

At least but I'll need to check a bit further into this and the autofs4
module should be updated in a similar manner. Even though it will
support the latest requested version it should still handle this error
case.

Ian



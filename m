Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWJWPCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWJWPCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWJWPCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:02:32 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:62293 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S964889AbWJWPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:02:31 -0400
Subject: Re: [patches] [PATCH] [18/19] x86_64: Overlapping program headers
	in physical addr space fix
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: vgoyal@in.ibm.com
Cc: Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       patches@x86-64.org, "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061023144145.GB15532@in.ibm.com>
References: <20061021651.356252000@suse.de>
	 <20061021165138.B8B5E13C4D@wotan.suse.de> <453C8966.76E4.0078.0@novell.com>
	 <20061023144145.GB15532@in.ibm.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 16:02:44 +0100
Message-Id: <1161615765.22514.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 15:02:31.0210 (UTC) FILETIME=[436868A0:01C6F6B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 10:41 -0400, Vivek Goyal wrote:
> On Mon, Oct 23, 2006 at 08:20:38AM +0100, Jan Beulich wrote:
> > >@@ -17,6 +17,7 @@ PHDRS {
> > > 	text PT_LOAD FLAGS(5);	/* R_E */
> > > 	data PT_LOAD FLAGS(7);	/* RWE */
> > > 	user PT_LOAD FLAGS(7);	/* RWE */
> > >+	data.init PT_LOAD FLAGS(7);	/* RWE */
> > > 	note PT_NOTE FLAGS(4);	/* R__ */
> > > }
> > > SECTIONS
> > 
> > Even though it's only cosmetic, I think it would have been
> > more than appropriate to remove the ill 'E' permission on data
> > with that change.
> 
> May be. I just kept it because already data segment had 'E' permissions.
> Ian, any reason why did you keep 'E' on data segment? If it is not
> intentional, I will get rid of it.

I wasn't 100% sure (only 99% :-)) it was unneeded so I kept it to
minimise the changes in the final image since the original .data section
had it.

> >(Btw., why does 'note' need 'R'?)
> 
> I went through the comments Ian had put in his patch. There also he 
> mentions that people objected to 'R' permissions for note segment as
> it is read only by boot loader. He kept it because i386 had the similar
> thing. 
> 
> Ian, again if there is no specific reason to keep 'R' for note, I will
> get rid of it.

There was a suggestion at one point that the note section was aliased by
a PT_LOAD and so needed the R but it turned out that wasn't the case.

You can drop it as far as I'm concerned.

Ian.


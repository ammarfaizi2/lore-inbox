Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTGTKB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTGTKB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:01:29 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:27060 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S263997AbTGTKBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:01:19 -0400
From: postmaster@lougher.demon.co.uk
To: "=?iso-8859-1?Q?J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, junkio@cox.net
In-Reply-To: <20030720082217.GA25468@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] Port SquashFS to 2.6
Date: Sun, 20 Jul 2003 11:16:18 +0100
User-Agent: Demon-WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <E19eBEo-0007h6-0Z@anchor-post-35.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joern@wohnheim.fh-wedel.de wrote:
> On Sat, 19 July 2003 22:40:22 -0700, junkio@cox.net wrote:
> > >>>>> "DD" == David Dillow <dave@thedillows.org> writes:
> > 
> > DD> Hmm, isn't that 4K allocated on the stack? Ouch.
> > 
> > Ouch indeed.  I was not looking for these things (I was just
> > porting not fixing).  Thank you for pointing it out.  Have a
> > couple of questions:
> > 

Thanks for sending the 2.6 patch, due to work pressure, I have had very little
time to do these things recently.  I am still, however, actively developing
squashfs (a 1.3 with some improvements will be released soon), and I'd prefer
to do code fixes myself.
  
> >  - Would it be an acceptable alternative here to use blocking
> >    kmalloc upon entry with matching kfree before leaving?
> > 
> >  - I would imagine that the acceptable stack usage for functions
> >    would depend on where they are called and what they call.
> >    Coulc you suggest a rule-of-thumb number for
> >    address_space_operations.readpage (say, would 1kB be OK but
> >    not 3kB?)
> 
> As a rule of thumb, stay below 1k or you will get regular email from
> me. :)

I tend to allocate (small) buffers on the stack, when their size does not
seem to warrant either: a globally kmalloced buffer and consequent locking,
or a locally kmalloced buffer kfreed on exit from the function, which seems
wasteful. However, if 1K is the perceived wisdom on stack limits, then I will
alter the code.

Phillip



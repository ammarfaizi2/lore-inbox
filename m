Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUJQTnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUJQTnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUJQTnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:43:06 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:43996 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269294AbUJQTls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:41:48 -0400
Message-ID: <004601c4b489$c3486f80$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Buddy Lucas" <buddy.lucas@gmail.com>
Cc: "Lars Marowsky-Bree" <lmb@suse.de>,
       "David Schwartz" <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017150509.GC10280@mark.mielke.cc> <5d6b65750410170840c80c314@mail.gmail.com> <000801c4b46f$b62034b0$161b14ac@boromir> <5d6b65750410171033d9d83ab@mail.gmail.com> <002b01c4b483$b2bef130$161b14ac@boromir> <5d6b657504101712336468303c@mail.gmail.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sun, 17 Oct 2004 21:42:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Buddy Lucas" <buddy.lucas@gmail.com>
> On Sun, 17 Oct 2004 20:58:39 +0100, Martijn Sipkema <martijn@entmoot.nl> wrote:
> > >
> > > But then I am one of those who thinks it's sane to check for
> > > EWOULDBLOCK on a nonblocking socket after blocking in select().
> > 
> > A POSIX comliant implementation would never do this.
> 
> Here's your own quote, from a couple of hundred mails ago:
> 
> > According to POSIX:
> 
> > A descriptor shall be considered ready for reading when a call to an
> >  input function with O_NONBLOCK clear would not block, whether or not
> >  the function would transfer data successfully.
> 
> You concluded from this that, if select() says a descriptor is
> readable, the subsequent recvmsg() must not block. The point is, from
> your quote I cannot deduct anything but: a recvmsg() on a descriptor
> that is readable must not block -- which makes perfect sense.
> 
> But unless POSIX also says something about the conservability of
> "readability" of descriptors, specifically in between select() and
> recvmsg(), your conclusion is just wrong.

But with the current Linux implementation it is possible that a call to select()
returns while a call to recvmsg() would have blocked, and that is not
correct according to POSIX.

And I indeed read this as meaning that the first recvmsg() after the select()
may not block.

> > > Let's just document this and move on to something more important.
> > 
> > It actually _is_ important. Just implement select() and recvmsg() as
> > described in the standard.
> 
> I am very glad Linux makes sane decisions while trying to adhere to
> the standards as much as possible.

I don't think this is ``trying to adhere to the standards''... not by a long shot.


--ms


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUDCDzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 22:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUDCDzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 22:55:17 -0500
Received: from mproxy.gmail.com ([216.239.56.240]:37235 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S261554AbUDCDzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 22:55:13 -0500
Message-ID: <2902D580.68763FDD@mail.gmail.com>
Date: Fri, 2 Apr 2004 19:55:08 -0800
From: Ross Biro <ross.biro@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] cowlinks v2
Cc: andersen@codepoet.org, Pavel Machek <pavel@ucw.cz>,
       =?ISO-8859-1?Q?=20=22J=F6rn?=.Engel" <joern@wohnheim.fh-wedel.de>, mj@ucw.cz, jack@ucw.cz,
	"Patrick.J.LoPresti" <patl@users.sourceforge.net>,
	linux-kernel@vger.kernel.org"@willy.net1.nerim.net
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	=?ISO-8859-1?Q?=20=22J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>, mj@ucw.cz, jack@ucw.cz, "Patrick J.LoPresti" <patl@users.sourceforge.net>, linux-kernel@vger.kernel.org"
			^												     ^	      ^-missing closing '"' in token
		|												      \-missing end of address
		\-extraneous tokens in address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	=?ISO-8859-1?Q?=20=22J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>, mj@ucw.cz, jack@ucw.cz, "Patrick J.LoPresti" <patl@users.sourceforge.net>, linux-kernel@vger.kernel.org"
			^												     ^	      ^-missing closing '"' in token
		|												      \-missing end of address
		\-extraneous tokens in address
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <20040403012112.GA6499@codepoet.org> <20040403015920.GA2857@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004 02:59:20 +0100, Jamie Lokier <jamie@shareable.org> wrote:
> 
> Erik Andersen wrote:
> > > Here's a tricky situation:
> > >
> > >    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> > >
> > >    2. At this point both mappings share the same pages in RAM.
> > >
> > >    3. Then one of the cowlinks is written to...
> >
> > Using mmap with PROT_WRITE on a cowlink must preemptively
> > break the link.
> 
> I forget to mention, they are PROT_READ shared mappings.

Or just also make the page cow and not break the link until someone
actually writes to it.  Really depends on how you view the performance
impact, whether you do cow at the block of inode level, and how much
you want to touch (or copy parts of) the mm.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTLOLvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLOLvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:51:54 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:36038
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263523AbTLOLvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:51:53 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Vladimir Saveliev <vs@namesys.com>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Mon, 15 Dec 2003 05:52:22 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <200312121535.22375.rob@landley.net> <1071482402.11042.36.camel@tribesman.namesys.com>
In-Reply-To: <1071482402.11042.36.camel@tribesman.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312150552.22805.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 December 2003 04:00, Vladimir Saveliev wrote:

> > Truncate doesn't look at the contents of the file, it just frees the
> > space regardless of what the data was.  (It doesn't have to load the
> > contents of the blocks into memory and look at them in order to make the
> > file's length shorter in the metadata and de-allocate those blocks.)
> >
> > What was suggested a bit earlier was automatically looking at the
> > contents of the data being written to disk, and not allocating actual
> > blocks if the data is all zeroes.  (A bit like looking at pages of memory
> > and copy-on-write aliasing them to the zero page whenever the page is
> > entirely zeroes.)
> >
> > Truncate doesn't do any of that.  Truncate only plays with metadata, and
> > doesn't care about the contents of the file.
>
> I thought we are talking about something which would allow to create
> holes inside of non sparse file

Yes.  With a syscall that says "from here, to here, punch hole".

The earlier suggestion I was disagreeing with would automatically create holes 
in any file that wrote a sufficiently large range of zero bytes.  Hence the 
cache poisoning and general defeating the purpose of DMA and such.  Neither 
truncate, nor a punch syscall, would mess with the normal "write" path 
(beyond locking so write and truncate/punch didn't stomp each other).

Rob

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264576AbTLLNw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTLLNw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:52:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45525
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264576AbTLLNwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:52:25 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Vladimir Saveliev <vs@namesys.com>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Fri, 12 Dec 2003 07:53:11 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <20031212125513.GC6112@wohnheim.fh-wedel.de> <1071235698.27730.146.camel@tribesman.namesys.com>
In-Reply-To: <1071235698.27730.146.camel@tribesman.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312120753.11906.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 07:28, Vladimir Saveliev wrote:
> Hi
>
> On Fri, 2003-12-12 at 15:55, Jörn Engel wrote:
> > On Thu, 11 December 2003 14:32:12 -0600, Rob Landley wrote:
> > > On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> > > > If you really do it, please don't add a syscall for it.  Simply check
> > > > each written page if it is completely filled with zero.  (This will
> > > > be a very quick check for most pages, as they will contain something
> > > > nonzero in the first couple of words)
> > >
> > > Cache poisoning, streaming writes to large RAID arrays...  There are
> > > about 8 zllion reasons not to do this.  Really.  (It defeats the whole
> > > purpose of DMA, doesn't it?)
>
> Sorry,
> but doesn't truncate do almost exactly what "make hole" is supposed to
> do?

I have a 2 gigabyte file.  I want to punch a hole from 257 megabytes to 364 
megabytes, saving over 100 megs of disk space.  I do NOT want to have to copy 
off and rewrite 1.6 gigabytes of data from the end of the file.  (There may 
not even be enough room on the disk, and it would take a long time anyway.)

No, it doesn't do the same thing.  Truncate is always to end of file.  Punch 
hole is like a write, it takes a length.  lseek(pos), punch(length).

Rob

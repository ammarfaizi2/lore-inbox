Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUEaQIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUEaQIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 12:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbUEaQIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 12:08:21 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:21942 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264686AbUEaQIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 12:08:18 -0400
Date: Mon, 31 May 2004 18:08:17 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file attributes (ext2/3) in 2.4.26
Message-ID: <20040531160816.GA16444@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040517185141.GA23102@MAIL.13thfloor.at> <20040520215909.GB21344@logos.cnet> <20040520224809.GA31445@MAIL.13thfloor.at> <20040531150537.GD20653@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531150537.GD20653@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 12:05:37PM -0300, Marcelo Tosatti wrote:
> On Fri, May 21, 2004 at 12:48:09AM +0200, Herbert Poetzl wrote:
> > On Thu, May 20, 2004 at 06:59:09PM -0300, Marcelo Tosatti wrote:
> > > On Mon, May 17, 2004 at 08:51:41PM +0200, Herbert Poetzl wrote:
> > > > 
> > > > Hi Folks!
> > > > 
> > > > is it intentional that the file attributes
> > > > (those accessible with chattr -*) are modifyable
> > > > even if a file has the 'i' immutable flag set,
> > > > and the user is lacking CAP_IMMUTABLE (or all
> > > > CAPs if you prefer that ;)
> > > > 
> > > > # touch /tmp/x
> > > > # chattr +iaA /tmp/x
> > > > 
> > > > # lcap -z
> > > > # chattr -i /tmp/x 
> > > > chattr: Operation not permitted while setting flags on /tmp/x
> > > > 
> > > > # chattr -A /tmp/x 
> > > > # lsattr /tmp/x
> > > > ----ia------- /tmp/x
> > > > 
> > > > I'd consider this a bug, but it might be some
> > > > strange posix/linux conformance issue too ...
> > > > 
> > > > let me know if this _is_ a bug, if so, I'm 
> > > > willing to provide patches to fix it ...
> > > 
> > > Hi Herbert,
> > > 
> > > The chattr man page says
> > > 
> > >   A file with the `i' attribute cannot be modified: it cannot be  deleted
> > >   or  renamed,  no  link  can  be created to this file and no data can be
> > >   written to the file.  Only the superuser or a  process  possessing  the
> > >   CAP_LINUX_IMMUTABLE capability can set or clear this attribute.
> > > 
> > > You still can modify other flags from the file, right?
> > 
> > yep, that is what I consider unexpected behavior, but the 
> > man page doesn't say anything about other flags ... 
> > 
> > in the example above (which should be easy to verify) the 
> > 'A' (noatime) flag is cleared while 'i' is set and the 
> > user (root) has no capability at all ...
> > 
> > the same is true for all other attribute flags for
> > ext2/ext3, reiserfs and probably other fs implementing
> > those attributes.
> 
> Hi again Herbert,
> 
> I suppose this is expected behaviour, a file with 'i' cannot 
> be modified, deleted or renamed and no link can be created to this 
> file and no data written to the file. Its valid to change the file
> attributes.

well, if the kernel development, at some point,
decides to get rid of the suid stuff, and replace
it by something CAP* based, then this will be fun,
as it is then possible to modify the attributes
of immutable files without CAP_IMMUTABLE ...
 
> Not sure if any standard covers this, but it does not seem to be 
> a problem. 

okay, I have to handle this in linux-vserver
anyway, so I just wanted to know if this was on
purpose or accidentially ...

> I suppose v2.6 behaves the same?

yep, it does ...

best,
Herbert


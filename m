Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271200AbTGWSho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271206AbTGWSho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:37:44 -0400
Received: from pro6.mtco.com ([207.179.200.252]:8418 "HELO ns.mtco.com")
	by vger.kernel.org with SMTP id S271200AbTGWShk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:37:40 -0400
From: Tom Felker <tcfelker@mtco.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: root= needs hex in 2.6.0-test1-mm2
Date: Wed, 23 Jul 2003 13:52:54 -0500
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307230156.40762.tcfelker@mtco.com> <20030723144351.A3367@infradead.org> <200307240133.36646.kernel@kolivas.org>
In-Reply-To: <200307240133.36646.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200307231352.54208.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 July 2003 10:33 am, Con Kolivas wrote:
> On Wed, 23 Jul 2003 23:43, Christoph Hellwig wrote:
> > On Wed, Jul 23, 2003 at 01:56:40AM -0500, Tom Felker wrote:
> > > I finally booted 2.6.0-test1-mm2, after reading somebody else who
> > > needed to use hex in the root= argument.  root=/dev/hdb1 and root=hdb2
> > > would panic ("VFS: Cannot open root device hdb1 or
> > > unknown-block(0,0)"), but root=0341 worked.  Devfs is compiled in,
> > > devfs=nomount and devfs=mount make no difference.  Is this intentional?
> >
> > Yes.  If you use devfs you have to use devfs names for root=.  It's
> > pretty simple.  Best option of course is to avoid devfs.

>From the perspective of an ignorant user, I kinda like the idea of devfs.

> ie use
>
> root=/dev/ide/host0/bus0/target1/lun0/part1
>
> or equivalent

Yes, this worked.  I guess now my question is, why does /dev/hdb1 work for 
2.6.0-test1, but not 2.6.0-test1-mm2?

Also, I just started getting oopses during startup and shutdown with 
test1-mm2, EIP at ext3_journaling_dirty_data or something similar, followed 
by a bunch of file not found errors.  I'm getting scared, I have valuable 
data on ext3.  I'll be looking into some way to capture this.

-- 
Tom Felker

Hack user friendliness onto a pure and simple system, because
you can't hack purity and simplicity onto a user friendly system.


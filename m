Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265178AbUEVDkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUEVDkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUEVDkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:40:15 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:59909 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S265178AbUEVDkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:40:11 -0400
Date: Fri, 21 May 2004 23:40:03 -0400
To: Andreas Amann <amann@physik.tu-berlin.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Message-ID: <20040522034003.GA6415@fieldses.org>
References: <200405131411.52336.amann@physik.tu-berlin.de> <200405171331.35688.amann@physik.tu-berlin.de> <1084809309.3669.17.camel@lade.trondhjem.org> <200405211727.14917.amann@physik.tu-berlin.de> <1085157602.3666.70.camel@lade.trondhjem.org> <20040521230545.GA787@bill.physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521230545.GA787@bill.physik.tu-berlin.de>
User-Agent: Mutt/1.5.6i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 01:05:45AM +0200, Andreas Amann wrote:
> On Fri, May 21, 2004 at 12:40:02PM -0400, Trond Myklebust wrote:
> > 
> > Hmm... It looks to me as if you are exporting that filesystem with the
> > "subtree_check" option enabled. Could you try to set "no_subtree_check"?
> 
> Thanks for that one, with "no_subtree_check" the problem disappears!
> What is the disadvantage of this option?

With "no_subtree_check" the server will not attempt to verify that a
given filehandle points to a file that is beneath an exported directory;
thus an attacker can guess filehandles of files not beneath any exported
directory and use those guessed filehandles to acces files you didn't
mean to export.

Even with "no_subtree_check", the server can still recognize which
filesystem a filehandle belongs to; so you're only in trouble if you
have files you don't want exported on the same partition as files you do
want exported.

See "man exports" for more.

--Bruce Fields

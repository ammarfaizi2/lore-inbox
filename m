Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUCKOcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCKOcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:32:11 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:54001 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261364AbUCKObb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:31:31 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: UID/GID mapping system
Date: Thu, 11 Mar 2004 08:31:02 -0600
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <1078958747.1940.80.camel@nidelv.trondhjem.org> <1078993757.1576.41.camel@quaoar>
In-Reply-To: <1078993757.1576.41.camel@quaoar>
MIME-Version: 1.0
Message-Id: <04031108310203.05054@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 02:29, Søren Hansen wrote:
> ons, 2004-03-10 kl. 23:45 skrev Trond Myklebust:
> > The NFSv4 client and server already do uid/gid mapping. That is
> > *mandatory* in the NFSv4 protocol, which dictates that you are only
> > allowed to send strings of the form user@domain on the wire.
>
> Clever!
>
> > If you really need uid/gid mapping for NFSv2/v3 too, why not just build
> > on the existing v4 upcall/downcall mechanisms?
>
> Because that would require changes to both ends of the wire. I want this
> to:
> 1. Work for ALL filesystems (NFS, smbfs, ext2(*) etc.)
> 2. Be transparent for the server.

It will be a major security vulnerability.

>
> *: For ext2, this could come in handy if you are moving disks between
> systems.

Mapping fails in this case due to UID loops (been there done that too - had to
spend a week changing uids because of it - most were quickly changed because
there was no conflict, but about 100 out of 1000 were in loops. Users had
multiple accounts on both machines, but different uids on each. You can end up
having to map the same uid to two different uids.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1750958AbWLLIEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWLLIEy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWLLIEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:04:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55597 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbWLLIEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:04:53 -0500
Date: Tue, 12 Dec 2006 00:04:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.19-mm1
Message-Id: <20061212000446.ed11fa07.akpm@osdl.org>
In-Reply-To: <20061212154354.90b39a7c.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061211005807.f220b81c.akpm@osdl.org>
	<20061212145341.a5f335a0.kamezawa.hiroyu@jp.fujitsu.com>
	<20061211220617.669da2d5.akpm@osdl.org>
	<20061212154354.90b39a7c.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 15:43:54 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Mon, 11 Dec 2006 22:06:17 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> > > When I use ftp on 2.6.19-mm1, transfered file is always broken.
> > > like this:
> > > ==
> > > [kamezawa@casares ~]$ file ./linux-2.6.19.tar.bz2 (got on 2.6.19-mm1)
> > > ./linux-2.6.19.tar.bz2: data
> > > (I confirmed original file was not broken.)
> > 
> > Yes, a couple of people have reported things like this.  Strange. 
> > test.kernel.org is showing mostly-green.  There's one fsx-linux failure (for
> > unclear reasons) on one of the x86_64 machines, all the rest are happy.
> > 
> > Which filesystem were you using?
> > 
> using ext3.
> > Can you investigate it a bit further please??  reboot, re-download, work
> > out how the data differs, etc?
> > 
> Hmm, this is summary of broken linux-2.6.19.tar.bz2 file (used od and diff) 

On 1k blocksize ext3,

	fsx-linux -r 512 -w 512 foo

fails immediately.  It works OK with blocksize==pagesize, which ia64
doesn't do.

It's the pagecache-deadlock-avoidance patchset.  I'll drop it again, and
shall nuke 2.6.19-mm1 somehow, thanks.

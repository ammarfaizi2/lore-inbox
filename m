Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTEOHMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEOHMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:12:02 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34193 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262270AbTEOHMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:12:01 -0400
Date: Thu, 15 May 2003 09:24:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
Message-ID: <20030515072425.GA7638@wohnheim.fh-wedel.de>
References: <20030514162323.GB16093@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0305142152500.12748-100000@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0305142152500.12748-100000@marcellos.corky.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 21:59:47 +0300, Yoav Weiss wrote:
> On Wed, 14 May 2003, Jörn Engel wrote:
> > On Wed, 14 May 2003 12:13:03 -0400, Ahmed Masud wrote:
> > >
> > > The idea is to have encryption keys for the pages to be unique on a
> > > per-uid per-process basis. So one user on the system cannot access (even
> > > if they are root) parts of another's private data.  To achieve this,
> > > different parts of swap device need to be encrypted with different keys.
> >
> > How do user *know* that root cannot simply bypass this security?
> >
> > Root, god, what's the difference? ;-)
> 
> Aside from what Ahmed said about about rootless systems, the per-process
> encryption reduces the window of opportunity for attackers who gain root
> (or physical access).
> 
> Try strings(1) on your swap device.  You'll be surprised at what you find.
> You'll probably recognize passwords you haven't useds for a long time, and
> a lot of other stuff you didn't expect.  Sometimes you can find whole ssh
> sessions there, plaintext.  (think xterm scroll buffer).
> 
> With per-process encryption, even if root decides to read the swap at some
> point (evil admin or an attacker who 0wn3d the box), the leakage is
> limited to processes currently running.

s/currently running/running now or in the future/

But apart from that, it does really reduce the window, agreed.

An alternative approach would simply zero all freed memory in the
system, with almost identical effects. Almost means you are missing
memory (that isn't cleared on reboot on all systems, ...) and this is
missing hard disk recovery that can read data already overwritten.

Arguments against this simpler approach?

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 

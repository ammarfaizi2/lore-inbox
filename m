Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264701AbSJ3O6x>; Wed, 30 Oct 2002 09:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264698AbSJ3O6w>; Wed, 30 Oct 2002 09:58:52 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:13293 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264701AbSJ3O6F>; Wed, 30 Oct 2002 09:58:05 -0500
Date: Wed, 30 Oct 2002 16:04:22 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.5.bk] allow sbp2 driver to compile again
Message-ID: <20021030150422.GJ17103@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux1394-devel@lists.sourceforge.net
References: <20021030141338.GF17103@tahoe.alcove-fr> <20021030142611.GG1521@phunnypharm.org> <20021030143218.GH17103@tahoe.alcove-fr> <20021030143720.GH1521@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030143720.GH1521@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 09:37:20AM -0500, Ben Collins wrote:

> > While we are at it, there are a lot of 'bad: scheduling while atomic!'
> > and 'sleeping function called from illegal context' when loading
> > the ohci1394/sbp2 drivers (detailed stack available when compiling
> > with CONFIG_DEBUG_KERNEL)...
> 
> Yeah, I've noticed aswell. Problem is I don't have a machine that runs
> 2.5.x stable enough to do some testing.

A quick look shows that (most of) the problems come from 
highlevel.c, in the add_host etc. methods, where each driver
add_host etc. methods are called (which do kmallocs and schedules)
while a read_lock is taken.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

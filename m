Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVCOX0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVCOX0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVCOX0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:26:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53688 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262016AbVCOXZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:25:42 -0500
Date: Tue, 15 Mar 2005 17:17:04 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Alan Modra <amodra@bigpond.net.au>
Cc: paulus@samba.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, anton@samba.org, olof@austin.ibm.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-Id: <20050315171704.08f3057a.moilanen@austin.ibm.com>
In-Reply-To: <20050315224836.GD21148@bubble.modra.org>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
	<16949.25552.640180.677985@cargo.ozlabs.ibm.com>
	<20050314155125.68dcff70.moilanen@austin.ibm.com>
	<16950.3484.416343.832453@cargo.ozlabs.ibm.com>
	<20050315155135.11b942ef.moilanen@austin.ibm.com>
	<20050315224836.GD21148@bubble.modra.org>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 09:18:36 +1030
Alan Modra <amodra@bigpond.net.au> wrote:

> On Tue, Mar 15, 2005 at 03:51:35PM -0600, Jake Moilanen wrote:
> > I believe the problem is that the last PT_LOAD entry does not have the
> > correct size, and we only mmap up to the sbss.  The .sbss, .plt, and
> > .bss do not get mmapped with the section.
> 
> Huh?  .sbss, .plt and .bss have no file contents, so of course p_filesz
> doesn't cover them.

Your right, those shouldn't be mmapped.  

set_brk() call is called on sbss, plt and bss.  There needs to be some
method to set execute permission, on those pieces as well.  Currently it
has no concept of what permission should be set.

Jake   

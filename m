Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbULPRoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbULPRoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbULPRng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:43:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59825 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261963AbULPRmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:42:44 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 09:42:20 -0800
User-Agent: KMail/1.7.1
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com> <200412161037.55293.bjorn.helgaas@hp.com>
In-Reply-To: <200412161037.55293.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412160942.20678.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 16, 2004 9:37 am, Bjorn Helgaas wrote:
> On Thursday 16 December 2004 9:50 am, Jesse Barnes wrote:
> > This patch documents the /proc/bus/pci interface and adds some optional
> > architecture specific APIs for accessing legacy I/O port and memory
> > space. This is necessary on platforms where legacy I/O port space doesn't
> > 'soft fail' like it does on PCs, and is useful for systems that can route
> > legacy space to different PCI busses.
>
> But we didn't resolve anything with respect to multiple PCI domains,
> did we?  As far as I can see, /proc/bus/pci currently doesn't support
> multiple domains at all.  I don't like the idea of adding new stuff
> that we already know is insufficient for machines in the very near
> future.  True, it's just extending an existing interface, but it
> seems like if we're going to the trouble of changing X, we might as
> well address multiple domains at the same time.

The problem with adding domain support is that it'll break existing users, 
unless it's added on the side somehow.  One thought I had was to document 
that /proc/bus/pci/ contains only busses from domain 0.  Machines with more 
than 1 domain could create /proc/bus/pci/domain/DDDD directories with busses 
in the DDDD domain underneath.  That wouldn't break existing applications, 
and would let you get at domains other than 0 if you needed to.

Jesse

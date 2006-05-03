Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWECPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWECPxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWECPxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:53:09 -0400
Received: from canuck.infradead.org ([205.233.218.70]:30089 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030219AbWECPxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:53:08 -0400
Subject: Re: [RFC] Advanced XIP File System
From: David Woodhouse <dwmw2@infradead.org>
To: Jared Hulbert <jaredeh@gmail.com>
Cc: Josh Boyer <jwboyer@gmail.com>, Nicolas Pitre <nico@cam.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
	 <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
	 <625fc13d0605030341h2a105f49r2b1b610547e30022@mail.gmail.com>
	 <1146658275.20773.8.camel@pmac.infradead.org>
	 <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 03 May 2006 16:52:57 +0100
Message-Id: <1146671577.20773.27.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 08:45 -0700, Jared Hulbert wrote:
> > We only need to mark those pages as absent in the page tables if we ever
> > schedule to userspace while the flash is in a mode other than read mode.
> > Then handle the page fault by switching the flash back or waiting for
> > it.
> 
> Where would we do this?  In each MTD driver?  A new generic aops function?

Probably a helper function with callbacks into the MTD driver. You ask
the MTD device driver to map a certain range of itself to userspace, and
it does so. Then it handles the page faults, etc. 

-- 
dwmw2


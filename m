Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266190AbUAVIpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbUAVIpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:45:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:8382 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266190AbUAVIpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:45:17 -0500
Date: Thu, 22 Jan 2004 00:45:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@users.sourceforge.net
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Shutdown IDE before powering off.
Message-Id: <20040122004554.26536158.akpm@osdl.org>
In-Reply-To: <1074759964.12536.65.camel@laptop-linux>
References: <1074735774.31963.82.camel@laptop-linux>
	<20040121234956.557d8a40.akpm@osdl.org>
	<200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
	<1074759964.12536.65.camel@laptop-linux>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
>
> Hi.
> 
> On Thu, 2004-01-22 at 21:13, John Bradford wrote:
> > > This spins down the disk(s) when you're just doing do a reboot.  That's
> > > fairly irritating and could affect reboot times if one has many disks.
> > 
> > I think it is an attempt to force some broken drives to flush their
> > cache, but I wonder whether it will simply move the problem from one
> > set of broken drives to another :-).
> 
> Yes, they were trying to get caches flushed. If this attempt is
> misguided, that's fine. Is there a better way?

A couple of thoughts come to mind:

a) Don't do it if the user typed reboot - only do it if we're powering down.

b) Try to do a cache flush instead.  If that fails (do we know?) then
   power down the disk instead.


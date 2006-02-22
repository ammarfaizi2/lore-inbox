Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWBVUyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWBVUyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWBVUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:54:08 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:31931 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751442AbWBVUyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:54:06 -0500
Subject: Re: [patch 1/1] selinux: Disable automatic labeling of new inodes
	when no policy is loaded
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jmorris@namei.org
In-Reply-To: <20060222123949.29a5cd2e.akpm@osdl.org>
References: <1140636986.31467.276.camel@moss-spartans.epoch.ncsc.mil>
	 <20060222123949.29a5cd2e.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 22 Feb 2006 15:59:33 -0500
Message-Id: <1140641973.31467.293.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 12:39 -0800, Andrew Morton wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > This patch disables the automatic labeling of new inodes on disk
> >  when no policy is loaded.  Please apply.
> >
> 
> What is the reason for this change, and what will its effects be?

Motivated by:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180296

The effect is simply that if you boot with SELinux enabled but no policy
loaded and create a file in that state, SELinux won't try to set a
security extended attribute on the new inode on the disk.  This is the
only sane behavior for SELinux in that state, as it cannot determine the
right label to assign in the absence of a policy.  That state usually
doesn't occur, but the rawhide installer seemed to be misbehaving
temporarily so it happened to show up on a test install.

-- 
Stephen Smalley
National Security Agency


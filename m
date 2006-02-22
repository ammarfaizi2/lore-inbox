Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWBVUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWBVUzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWBVUzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:55:05 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:63393 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751440AbWBVUzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:55:04 -0500
Date: Wed, 22 Feb 2006 15:55:02 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] selinux: Disable automatic labeling of new inodes
 when no policy is loaded
In-Reply-To: <20060222123949.29a5cd2e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602221551380.31473@excalibur.intercode>
References: <1140636986.31467.276.camel@moss-spartans.epoch.ncsc.mil>
 <20060222123949.29a5cd2e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Andrew Morton wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > This patch disables the automatic labeling of new inodes on disk
> >  when no policy is loaded.  Please apply.
> 
> What is the reason for this change, and what will its effects be?

Discussion is here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180296

In short, we're changing the behavior so that when no policy is loaded, 
SELinux does not label files at all.  Currently it does add an 'unlabeled' 
label in this case, which we've found causes problems later.

SELinux always maintains a safe internal label if there is none, so with 
this patch, we just stick with that and wait until a policy is loaded 
before adding a persistent label on disk.


- James
-- 
James Morris
<jmorris@namei.org>

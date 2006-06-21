Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWFUTwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWFUTwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWFUTwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:52:10 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:29359 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030233AbWFUTvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:51:49 -0400
Date: Wed, 21 Jun 2006 15:51:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/3] SELinux: add security_task_setmempolicy hooks to mm
 code
In-Reply-To: <Pine.LNX.4.64.0606211230230.21024@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606211544420.11782@d.namei>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211520540.11782@d.namei>
 <Pine.LNX.4.64.0606211230230.21024@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Christoph Lameter wrote:

> On Wed, 21 Jun 2006, James Morris wrote:
> 
> > From: David Quigley <dpquigl@tycho.nsa.gov>
> > 
> > This patch inserts the security hook calls into the setmempolicy function 
> > to enable security modules to mediate this operation between tasks.
> 
> Setting a memory policy is different from migrating pages of an 
> application. The migration function migrates a process, it does not set 
> any memory policies. Cpuset may change memory policies of the tasks 
> contained in it but sys_migrate_pages() cannot.

I'll let David and/or Stephen address this in detail, but what's being 
added here is a security asbtraction, where we consider these operations 
to be equivalent from an access control point of view.  So, one task 
causing another task's memory to be moved to another node is conisdered to 
be "setting memory policy" at a conceptual level.  Perhaps we could change 
the name of the hook to make that clearer (which you suggest below).

> We need a similar hook for the sys_move_pages() function call in mm right?

Yes, the hook is also added to sys_move_pages() in the patch.

> If this is a generic hook then I would suggest to have some hook that 
> contains the term "memory placement" somewhere that would fit both system 
> calls.
> 

-- 
James Morris
<jmorris@namei.org>

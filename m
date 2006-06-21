Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWFUTed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWFUTed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWFUTed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:34:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54990 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932693AbWFUTeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:34:15 -0400
Date: Wed, 21 Jun 2006 12:33:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: James Morris <jmorris@namei.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/3] SELinux: add security_task_setmempolicy hooks to mm
 code
In-Reply-To: <Pine.LNX.4.64.0606211520540.11782@d.namei>
Message-ID: <Pine.LNX.4.64.0606211230230.21024@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211520540.11782@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, James Morris wrote:

> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch inserts the security hook calls into the setmempolicy function 
> to enable security modules to mediate this operation between tasks.

Setting a memory policy is different from migrating pages of an 
application. The migration function migrates a process, it does not set 
any memory policies. Cpuset may change memory policies of the tasks 
contained in it but sys_migrate_pages() cannot.

We need a similar hook for the sys_move_pages() function call in mm right?

If this is a generic hook then I would suggest to have some hook that 
contains the term "memory placement" somewhere that would fit both system 
calls.



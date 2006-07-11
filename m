Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWGKF0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWGKF0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWGKF0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:26:52 -0400
Received: from xenotime.net ([66.160.160.81]:19614 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965057AbWGKF0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:26:52 -0400
Date: Mon, 10 Jul 2006 22:29:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Bill Ryder <bryder@wetafx.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x
 kernels
Message-Id: <20060710222938.6810a7e1.rdunlap@xenotime.net>
In-Reply-To: <44B32888.6050406@wetafx.co.nz>
References: <44B32888.6050406@wetafx.co.nz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 16:26:48 +1200 Bill Ryder wrote:

> Hello all,
> 
> I've read all the stuff on submitting patches and this seems to be the
> place.
> 
> Please CC me on any replies to this (although I do watch this through
> list with  gmane)
> 
> Here's the patch description. I've attached the patch. Hopefully I've
> followed the rules in Documentation/Submit* - apart from CC'ing Linus).

6) No MIME, no links, no compression, no attachments.  Just plain text.

Attachments make it difficult to review/comment.

You'll likely need to coax Andrew into merging/testing it in -mm
rather than sending it to Linus.

> Summary:
> 
> Patch to allow the option of not sorting a process's supplemental
> (also known ask secondary aka supplementary) group list. 
> 
> Setting the kernel config option of UNSORTED_SUPPLEMENTAL_GROUPLIST
> will allow the use of setgroups(2) to reorder a supplemental
> group list to work around the NFS AUTH_UNIX 16 group limit. 
> 
> In fact I  think this should be the default option because anyone using
> setgroups
> may get an unpleasant surprise with 2.6.x. But for now this patch makes
> it an option.
> 
> Longer version:
> 
> Like many places Weta Digital (we did the VFX for Lord of the Rings,
> King Kong etc)
> uses supplemental group lists to allow users access to multiple
> directories and files (films mostly in our
> case) . Unfortunately NFSv2 and NFSv3 AUTH_UNIX flavour authentication
> is hardcoded to only support 16 supplemental groups. Since we currently
> have some users and processes which need to be in more than 16 groups
> we use setgroups to build a list of groups that a process requires when
> they access data on nfs exported filesystems.
> 
> This worked fine for the 2.4.x kernels. 2.6.x is designed to handle
> thousands of groups for a single user. To support that the kernel was
> changed to sort the group list, then use a binary search to decide if
> a user was in the correct group. Unfortunately this BREAKS the use of
> setgroups(2) to put the 16 most important groups first. 
> 
> This patch provides the option of not sorting that list. The help
> describes the pitfalls of not sorting the groups (performance when
> there are a lot of groups).

Patch comments:

Keep Kconfig help text to less than 80 columns so that it fits in
an xterm without requiring left/right scrolling.

Keep source code/comments within 80 columns (for xterms again).
So this comment needs to be broken/split:

+/* if USE_UNSORTED_SUPPLEMENTAL_GROUPS is set this is a linear search. If not it's a binary search */

In the groups_search() function, all data needs to be declared
before any executable code statements.

Lines like this:
+#ifdef USE_UNSORTED_SUPPLEMENTAL_GROUPS

should be:
+#ifdef CONFIG_USE_UNSORTED_SUPPLEMENTAL_GROUPS

i.e., the config system prefixes all config symbols with CONFIG_.

Was it tested like this?
Look at Documentation/SubmitChecklist along with
Documentation/SubmittingPatches.

---
~Randy

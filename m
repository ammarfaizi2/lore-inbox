Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVIDFt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVIDFt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 01:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVIDFt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 01:49:58 -0400
Received: from smtp.istop.com ([66.11.167.126]:10695 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751178AbVIDFt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 01:49:57 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Sun, 4 Sep 2005 01:52:29 -0400
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040051.11095.phillips@istop.com> <20050904050026.GU8684@ca-server1.us.oracle.com>
In-Reply-To: <20050904050026.GU8684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509040152.30027.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 01:00, Joel Becker wrote:
> On Sun, Sep 04, 2005 at 12:51:10AM -0400, Daniel Phillips wrote:
> > Clearly, I ought to have asked why dlmfs can't be done by configfs.  It
> > is the same paradigm: drive the kernel logic from user-initiated vfs
> > methods.  You already have nearly all the right methods in nearly all the
> > right places.
>
>  configfs, like sysfs, does not support ->open() or ->release()
> callbacks.

struct configfs_item_operations {
 void (*release)(struct config_item *);
 ssize_t (*show)(struct config_item *, struct attribute *,char *);
 ssize_t (*store)(struct config_item *,struct attribute *,const char *, size_t);
 int (*allow_link)(struct config_item *src, struct config_item *target);
 int (*drop_link)(struct config_item *src, struct config_item *target);
};

struct configfs_group_operations {
 struct config_item *(*make_item)(struct config_group *group, const char *name);
 struct config_group *(*make_group)(struct config_group *group, const char *name);
 int (*commit_item)(struct config_item *item);
 void (*drop_item)(struct config_group *group, struct config_item *item);
};

You do have ->release and ->make_item/group.

If I may hand you a more substantive argument: you don't support user-driven
creation of files in configfs, only directories.  Dlmfs supports user-created
files.  But you know, there isn't actually a good reason not to support
user-created files in configfs, as dlmfs demonstrates.

Anyway, goodnight.

Regards,

Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbSJDPA6>; Fri, 4 Oct 2002 11:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbSJDPAV>; Fri, 4 Oct 2002 11:00:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261936AbSJDPAM>;
	Fri, 4 Oct 2002 11:00:12 -0400
Date: Fri, 4 Oct 2002 16:05:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
Message-ID: <20021004160543.E18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your list_member macro:

+static inline int list_member(struct list_head *member)
+{
+ return ((!member->next || !member->prev) ? 0 : 1);
+}

seems wrong to me.  A list head which has been removed from its list using
list_del() still points to its old prev & next entries.  If removed using
list_del_init(), those pointers are reinitialised to point at itself.
ie you only need list_empty().  Are you abusing list.h somehow?

-- 
Revolutions do not require corporate support.

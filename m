Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbSJDPhT>; Fri, 4 Oct 2002 11:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSJDPhT>; Fri, 4 Oct 2002 11:37:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7400 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262060AbSJDPhS>;
	Fri, 4 Oct 2002 11:37:18 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFDA00C8D3.E99FDDA0-ON85256C48.005322C4@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 4 Oct 2002 10:48:33 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 11:42:14 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/2002 at 10:05 AM, Matthew Wilcox wrote:
> Your list_member macro:

> +static inline int list_member(struct list_head *member)
> +{
> + return ((!member->next || !member->prev) ? 0 : 1);
> +}

> seems wrong to me.  A list head which has been removed from its list
using
> list_del() still points to its old prev & next entries.  If removed using
> list_del_init(), those pointers are reinitialised to point at itself.
> ie you only need list_empty().  Are you abusing list.h somehow?

list_empty() can be used on check list heads *or*
to check if a list element is currently in a list,
assuming the coder uses list_del_init(). However,
if the coder chooses to use list_del() [which sets
the prev and next fields to 0] instead, there is no
corresponding function to indicate if that element
is currently on a list. This function does that.

Mark



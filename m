Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTFEQtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTFEQtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:49:22 -0400
Received: from [203.145.184.221] ([203.145.184.221]:64013 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S264756AbTFEQrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:47:23 -0400
Subject: [PATCH] [2.5] [CLEANUP] remove unused include/asm-s390/queue.h
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: linux390@de.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Jun 2003 22:40:55 +0530
Message-Id: <1054833055.1469.6.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

include/asm-s390/queue.h: This file is no more used. The attached patch
removes this.

vinay

--- linux-2.5.70/include/asm-s390/queue.h	2003-05-27 09:39:40.000000000 +0530
+++ /dev/null	2002-08-31 05:01:37.000000000 +0530
@@ -1,170 +0,0 @@
-/*
- *  include/asm-s390/queue.h
- *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *
- *  A little set of queue utilies.
- */
-#ifndef __ASM_QUEUE_H
-#define __ASM_QUEUE_H
-#include <linux/stddef.h>
-
-typedef struct queue
-{
-	struct queue *next;	
-} queue;
-
-typedef queue list;
-
-typedef struct
-{
-	queue *head;
-	queue *tail;
-} qheader;
-
-static __inline__ void init_queue(qheader *qhead)
-{
-	memset(qhead,0,sizeof(*qhead));
-}
-
-static __inline__ void enqueue_tail(qheader *qhead,queue *member)
-{	
-	if(member)
-	{
-		queue *tail=qhead->tail;
-
-		if(tail)
-			tail->next=member;
-		else
-			
-			qhead->head=member;
-		qhead->tail=member;
-		member->next=NULL;
-	}
-} 
-
-static __inline__ queue *dequeue_head(qheader *qhead)
-{
-	queue *head=qhead->head,*next_head;
-
-	if(head)
-	{
-		next_head=head->next;
-		qhead->head=next_head;
-	        if(!next_head)
-			qhead->tail=NULL;
-	}
-	return(head);
-}
-
-static __inline__ void init_list(list **lhead)
-{
-	*lhead=NULL;
-}
-
-static __inline__ void add_to_list(list **lhead,list *member)
-{
-	member->next=*lhead;
-	*lhead=member;
-}
-
-static __inline__ list *remove_listhead(list **lhead)
-{
-	list *oldhead=*lhead;
-
-	if(oldhead)
-		*lhead=(*lhead)->next;
-	return(oldhead);
-}
-
-static __inline__ void add_to_list_tail(list **lhead,list *member)
-{
-	list *curr,*prev;
-	if(*lhead==NULL)
-		*lhead=member;
-	else
-	{
-		prev=*lhead;
-		for(curr=(*lhead)->next;curr!=NULL;curr=curr->next)
-			prev=curr;
-		prev->next=member;
-	}
-}
-static __inline__ void add_to_list_tail_null(list **lhead,list *member)
-{
-	member->next=NULL;
-	add_to_list_tail_null(lhead,member);
-}
-
-
-static __inline__ int is_in_list(list *lhead,list *member)
-{
-	list *curr;
-
-	for(curr=lhead;curr!=NULL;curr=curr->next)
-		if(curr==member)
-			return(1);
-	return(0);
-}
-
-static __inline__ int get_prev(list *lhead,list *member,list **prev)
-{
-	list *curr;
-
-	*prev=NULL;
-	for(curr=lhead;curr!=NULL;curr=curr->next)
-	{
-		if(curr==member)
-			return(1);
-		*prev=curr;
-	}
-	*prev=NULL;
-	return(0);
-}
-
-
-
-static __inline__ int remove_from_list(list **lhead,list *member)
-{
-	list *prev;
-
-	if(get_prev(*lhead,member,&prev))
-	{
-
-		if(prev)
-			prev->next=member->next;
-		else
-			*lhead=member->next;
-		return(1);
-	}
-	return(0);
-}
-
-static __inline__ int remove_from_queue(qheader *qhead,queue *member)
-{
-	queue *prev;
-
-	if(get_prev(qhead->head,(list *)member,(list **)&prev))
-	{
-
-		if(prev)
-		{
-			prev->next=member->next;
-			if(prev->next==NULL)
-				qhead->tail=prev;
-		}
-		else
-		{
-			if(qhead->head==qhead->tail)
-				qhead->tail=NULL;
-			qhead->head=member->next;
-		}
-		return(1);
-	}
-	return(0);
-}
-
-#endif /* __ASM_QUEUE_H */
-


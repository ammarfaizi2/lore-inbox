Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVKZMKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKZMKj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVKZMKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:10:39 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:51597 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750835AbVKZMKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:10:38 -0500
Message-ID: <438851F5.80304@student.ltu.se>
Date: Sat, 26 Nov 2005 13:15:49 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nanakos@wired-net.gr
CC: linux-kernel@vger.kernel.org
Subject: Re: Ordered Sorted List
References: <1131.62.1.12.53.1133000719.squirrel@webmail.wired-net.gr>
In-Reply-To: <1131.62.1.12.53.1133000719.squirrel@webmail.wired-net.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nanakos Chrysostomos wrote:

>Hi ,all.Can someone please explain this source code with an example???
>
>  
>
Homework?

>***********************************************************************
>#include <stdio.h>
>
>typedef struct list_tag {
>        int data;
>        struct list_tag *next;
>}ListNode;
>
>typedef ListNode *slist;
>slist empty = NULL;
>
>void slistInsert(slist *sp,int t)
>{
>        ListNode *n=(ListNode *)malloc(sizeof(ListNode));
>        if(n == NULL)
>        {
>                printf("Out of memory\n");
>                exit(1);
>        }
>        n->data = t;
>        while(*sp!=NULL && (*sp)->data < t)
>        {
>        sp = &((*sp)->next);   //Why we do this here,i miss this point
>        }
>  
>
This is a _sorted_ list, right. So somehow we have to sort it.
What it does is to either find a node with a value higher then 't', or 
it reach the end of the list. Meanwhile, it just continue walking the list.

>        n->next = *sp;
>        *sp = n;
>  
>
... so here we hock the rest of the list with the new node.

>}
>
>
>void slistRemove(slist *sp,int t)
>{
>        ListNode *n;
>        while(*sp!=NULL && (*sp)->data <t)
>                sp = &((*sp)->next);
>        if(*sp == NULL)
>        {
>                printf("Not found\n");
>                exit(1);
>        }
>
>        n=*sp;
>        *sp = (*sp)->next;
>        free(n);
>}
>
>void slistPrint(slist s)
>{
>        ListNode *n;
>        for(n=s;n!=NULL; n=n->next)
>                printf("%d\n",n->data);
>}
>
>void main()
>{
>
>  
>
NULL

>      slistInsert(&empty,4);
>  
>
4->NULL

>      slistInsert(&empty,8);
>  
>
4->8->NULL

>      slistInsert(&empty,24);
>
4->8->24->NULL

>      slistInsert(&empty,50);
>  
>
4->8->24->50->NULL

>      slistInsert(&empty,20);
>  
>
4->8->20->24->50->NULL

>      slistInsert(&empty,2);
>  
>
2->4->8->20->24->50->NULL

>      slistRemove(&empty,4);
>  
>
Remove first value equal or more than 4.
2->8->20->24->50->NULL

>      slistInsert(&empty,18);
>  
>
2->8->18->20->24->50->NULL

>      slistPrint(empty);
>  
>
2
8
18
20
24
50

>}
>
>Thank you very much in advance.
>  
>
cu
/Richard Knutsson

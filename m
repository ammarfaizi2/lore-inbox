Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319193AbSIDOcA>; Wed, 4 Sep 2002 10:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319195AbSIDOcA>; Wed, 4 Sep 2002 10:32:00 -0400
Received: from jalon.able.es ([212.97.163.2]:11164 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S319193AbSIDOb7>;
	Wed, 4 Sep 2002 10:31:59 -0400
Date: Wed, 4 Sep 2002 16:36:15 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Message-ID: <20020904143615.GC1949@werewolf.able.es>
References: <20020904024428.727A02C19C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020904024428.727A02C19C@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Sep 04, 2002 at 04:44:42 +0200
X-Mailer: Balsa 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.04 Rusty Russell wrote:
>In message <Pine.LNX.4.44.0209031923290.1513-100000@home.transmeta.com> you wri
>te:
...
>
>I'm confused, but I do know three things:
>
>1) list_t *bad*,
>
>2) Grand renaming of "struct list_head" *bad*, and
>

Why not something like:

struct list_node {
    struct list_node *prev;
    struct list_node *next;
}

struct list {
    struct list_node *prev;
    struct list_node *next;
}   
        
list_length(struct list *l)
list_add(struct list_node *new, struct list *head)
list_splice(struct list *list, struct list *head)

New:

#define list_sublist_from(node) ((struct list *)node)

So people would be forced to think if he is using a 'list_head'
as a node or as a sublist, and do the right casts to shut up the
compiler (that's why you can't do a typedef list_node list..., for
the compiler to scream...)


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre5-j0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUIHPkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUIHPkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUIHPkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:40:00 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63133 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268346AbUIHPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:39:58 -0400
Date: Wed, 8 Sep 2004 16:39:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: cmm@us.ibm.com, <dipankar@us.ibm.com>, <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Put size in array to get rid of barriers in
    grow_ary()
In-Reply-To: <20040907230936.GA13387@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0409081623380.8697-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, Paul E. McKenney wrote:
> 
> The grow_ary() code has a number of explicit memory barriers, as does
> ipc_lock().  This patch gets rid of the need for some of these by
> placing the array size in the same block of memory containing the
> array itself, so that the array and the size cannot possibly get out
> of sync.  Also uses rcu_assign_pointer() to get rid of the remaining
> smp_wmb().

But Paul, if you keep removing all these examples of memory barriers,
how can I be expected to learn how to use them properly?

Seriously, good, yes, the fewer "mb"s the better.
I could always educate myself from the older source.

> Untested, therefore probably broken.

Agreed ;)

> Thoughts?

Wouldn't it be a little nicer to start ipc_ids off pointing to a
const ipc_id_ary of size 0, to avoid the various entries == NULL
tests you had to add?

Hugh


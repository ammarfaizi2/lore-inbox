Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTDWSnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTDWSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:43:18 -0400
Received: from gsaix2.cc.GaSoU.EDU ([141.165.1.57]:30988 "EHLO
	gsaix2.cc.GaSoU.EDU") by vger.kernel.org with ESMTP id S264244AbTDWSlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:41:50 -0400
Message-Id: <200304231853.h3NIrnQg022656@gsaix2.cc.GaSoU.EDU>
To: linux-kernel@vger.kernel.org
From: bobcook@gsaix2.cc.gasou.edu
Subject: kernel/user.c suggestion
Date: Wed, 23 Apr 2003 14:55:37 US/Eastern
X-Mailer: GSWeb Mail Services Standard Edition v3.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lxr.linux.no/source/kernel/user.c?v=2.5.56#L81

81 struct user_struct * alloc_uid(uid_t uid)
82 {
83         struct list_head *hashent = uidhashentry(uid);
84         struct user_struct *up;
85 
86         spin_lock(&uidhash_lock);
87         up = uid_hash_find(uid, hashent);
88         spin_unlock(&uidhash_lock);

 

The code uses a hash table with multiple chains to reduce search time but then 
uses a single lock for the whole table??

Suggest one lock per chain for better concurrency so code mod would be 
spin_lock(&uidhash_lock[hashent])


Bob Cook


---------------------------------------------
This message was sent using GSWeb Mail Services.
http://www.gasou.edu/gsumail



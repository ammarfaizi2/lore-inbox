Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266335AbUGJSWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266335AbUGJSWq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUGJSWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:22:46 -0400
Received: from [80.72.36.106] ([80.72.36.106]:19114 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266335AbUGJSVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:21:52 -0400
Date: Sat, 10 Jul 2004 20:21:48 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Subject: gcc and aligning
Message-ID: <Pine.LNX.4.58.0407102007410.25422@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to experiment with real Linux kernel programming. And I have 
this question.

I have:

struct tree_node {
	struct tree_node *left, *right;
	...
};

struct some1 {
	struct tree_node n;
	...
};

struct some2 {
	struct tree_node n;
	...
};


And I want to write universal function that searches tree of structs some1 
or some2 (but one kind of struct per one tree). Like this:

struct tree_node *search(struct tree_node *root, struct tree_node *key, 
size_t size_of_the_struct);

And in this function I want to compare the _rest_ of some1 or some2 (the 
key) against other nodes. But gcc can insert some alignment between n and 
the rest of some1 or some2. Can I assume that the alignment fill is the 
same in all instances of this struct (for example 0 bytes) and use memcmp 
to compare bytes from begin_of_the_struct + sizeof(struct tree_node) to 
begin_of_the_struct + size_of_the_struct? 

Or is there some better solution?


Thanks,

Grzegorz Kulewski


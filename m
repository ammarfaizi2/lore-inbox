Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWDYJPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWDYJPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWDYJPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:15:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:58498 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932160AbWDYJPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:15:49 -0400
Date: Tue, 25 Apr 2006 11:15:30 +0200 (MEST)
Message-Id: <200604250915.k3P9FUbY029686@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Profile likely/unlikely macros
Cc: akpm@osdl.org, hzhong@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006 19:57:47 -0700, Daniel Walker wrote:
>+	if (likeliness->type & LIKELY_UNSEEN) {
>+		if (atomic_dec_and_test(&likely_lock)) {
>+			if (likeliness->type & LIKELY_UNSEEN) {
>+				likeliness->type &= (~LIKELY_UNSEEN);
>+				likeliness->next = likeliness_head;
>+				likeliness_head = likeliness;
>+			}
>+		}
>+		atomic_inc(&likely_lock);
>+	}

I'm pretty sure one can do this (prepending an element to a list)
w/o fiddling with locks by using CAS and looping until successful.

/Mikael

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTKRXKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTKRXKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:10:30 -0500
Received: from dp.samba.org ([66.70.73.150]:56979 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263836AbTKRXKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:10:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
From: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>, sds@epoch.ncsc.mil, aviro@redhat.com,
       linux-kernel@vger.kernel.org, russell@coker.com.au
Subject: Re: Fw: Re: [PATCH][RFC] Remove CLONE_FILES from init kernel thread creation 
In-reply-to: Your message of "Mon, 17 Nov 2003 13:32:40 -0800."
             <20031117133240.04e9c8e8.akpm@osdl.org> 
Date: Tue, 18 Nov 2003 15:42:23 +1100
Message-Id: <20031118231021.D61362C242@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031117133240.04e9c8e8.akpm@osdl.org> you write:
> 
> Rusty?   Any idea why call_usermodehelper() uses CLONE_FILES?

Your guess is correct about consolidation.  But there is no bug
AFAICT.

The "normal" (non-waiting case) uses "CLONE_VFORK | SIGCHLD".  The
"waiting" case uses "CLONE_KERNEL", but then that thread does another
fork with just "SIGCHLD".

ie. the actual thread which does the exec never uses CLONE_FILES.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUEICUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUEICUr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 22:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEICUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 22:20:47 -0400
Received: from vinc17.net1.nerim.net ([62.4.18.82]:49257 "EHLO ay.vinc17.org")
	by vger.kernel.org with ESMTP id S264258AbUEICUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 22:20:45 -0400
Date: Sun, 9 May 2004 04:20:43 +0200
From: Vincent Lefevre <vincent@vinc17.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040509022043.GE23263@ay.vinc17.org>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.org>,
	linux-kernel@vger.kernel.org
References: <20040509001045.GA23263@ay.vinc17.org> <Pine.LNX.4.53.0405082142100.25076@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0405082142100.25076@chaos>
X-Mailer-Info: http://www.vinc17.org/mutt/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-05-08 22:04:30 -0400, Richard B. Johnson wrote:
> What made you think that malloc would return 0 if the system
> was "out of memory??" Malloc will return NULL, which is not 0 BTW,
> if you are out of address-space or have corrupted it by writing
> past a previous allocation. Malloc's return value is a void *. It
> should be compared against NULL, not zero.

You are wrong. They are the same value (this is required by the ISO C
standard), i.e. both NULL == (void *) 0 and NULL == 0 must be true.

> When malloc() needs new "memory". It just asks the kernel to
> set the new break address or, in the case of mmap() mallocs, asks
> to extend a mapped region. Until somebody actually uses those
> regions, you haven't used any memory. So there is no way for
> malloc() to "know" ahead of time.

Again, you are wrong. The goal of malloc is to reserve memory.
This can be seen as used memory. If the implementation behaves
differently, then it is broken.

> If you run a malloc() bomb from the root account you should
> end up killing off a lot of processes. If you run it from
> a normal user account, and you have set the user's resource
> quotas properly, only the user should get into trouble.

The quotas are set properly (i.e. there are no quotas).

-- 
Vincent Lefèvre <vincent@vinc17.org> - Web: <http://www.vinc17.org/>
100% validated (X)HTML - Acorn / RISC OS / ARM, free software, YP17,
Championnat International des Jeux Mathématiques et Logiques, etc.
Work: CR INRIA - computer arithmetic / SPACES project at LORIA

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbUKALFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUKALFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUKALFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:05:11 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:63837 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbUKALFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:05:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=XLvyCb+V5GGd4MJi1//h785rZ9q5G6UMhyoleP7iQFu9nA8eZpuGt29KklzWemV3bTYy0IKl/CXyOcdeD7oU8GJXOSmMiPS5on3mV9LMKM7mExZBHz8QMaQdCmxB15dIH2OE3SVo0n8nS2V3c4vav7hJICs0+4cmiG9eugeT6C8=
Message-ID: <cb62342b04110103057dc7dff0@mail.gmail.com>
Date: Mon, 1 Nov 2004 12:05:04 +0100
From: Carlos Vidal <yorugua@gmail.com>
Reply-To: carlos@tarkus.se
To: linux-kernel@vger.kernel.org
Subject: spinlock_t typedef visibility and uninitialized spinlock
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm porting CIPE 1.6.0 kernel module to Kernel 2.6.8 and had problems
with "spin_is_locked on uninitialized spinlock".

After tracing the problem I found that the spinlock_t structure is not
visible to the module code. A 'gcc -E' yields:
     typedef struct { } spinlock_t;

In spinlock.h, this declaration is inside a #ifdef
CONFIG_DEBUG_SPINLOCK block, so it becomes visible only
CONFIG_DEBUG_SPINLOCK is 'y'.

If I turn CONFIG_DEBUG_SPINLOCK on, the module loads nicely. Otherwise
I get a nasty error in syslog and sometimes a system crash, as if in
CIPE the struct was not allocated (what is the case if the compiler
uses the typedef as it is above).

The question is: is this a bug or a feature? ;-)

Should the declaration be out of the #ifdef CONFIG_DEBUG_SPINLOCK? Or
should I use a special compiler flag?

Carlos

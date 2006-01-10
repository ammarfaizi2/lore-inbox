Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWAJOTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWAJOTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWAJOTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:19:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932163AbWAJOTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:19:37 -0500
From: David Howells <dhowells@redhat.com>
To: mingo@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: Mutex compilation error
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 10 Jan 2006 14:19:27 +0000
Message-ID: <2758.1136902767@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I've found a compilation error in mutexes when using the null variety:

	In file included from kernel/mutex-debug.c:25:
	kernel/mutex-debug.h:23:1: warning: "__IP__" redefined
	In file included from include/asm/mutex.h:9,
			 from kernel/mutex-debug.c:23:
	include/asm-generic/mutex-null.h:15:1: warning: this is the location of the previous definition

It seems that mutex-null.h defined __IP__ before mutex-debug.h because in
mutex-debug.c:

	#include <asm/mutex.h>

	#include "mutex-debug.h"

is the ordering of the includes.

Whilst mutex-null.h defends against multiple inclusions of __IP__,
mutex-debug.h does not.

David

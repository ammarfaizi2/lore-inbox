Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUESGTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUESGTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 02:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUESGTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 02:19:44 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:26327
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264058AbUESGTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 02:19:42 -0400
Message-ID: <40AAFC4A.5080309@redhat.com>
Date: Tue, 18 May 2004 23:18:50 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Davis <alex14641@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: signal handling issue.
References: <20040519054507.63816.qmail@web50201.mail.yahoo.com>
In-Reply-To: <20040519054507.63816.qmail@web50201.mail.yahoo.com>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix your code:

> static void handler(int s) {
>         printf("caught signal %d\n", s);
>         longjmp(env, 1);
> }

Use siglonjmp() and sigsetjmp().  You are not allowed to use longjmp()
to jump from a signal handler.

[How many times have I explained this here now?]

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUIGLu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUIGLu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUIGLu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:50:28 -0400
Received: from mx02.qsc.de ([213.148.130.14]:16052 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S267866AbUIGLtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:49:32 -0400
Date: Tue, 07 Sep 2004 13:48:54 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <413DA026.nail9XE11008R@pluto.uni-freiburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
 <20040904153902.6ac075ea.akpm@osdl.org>
 <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
 <20040906133523.GC25429@wohnheim.fh-wedel.de>
 <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
 <20040907110913.GA25802@wohnheim.fh-wedel.de>
In-Reply-To: <20040907110913.GA25802@wohnheim.fh-wedel.de>
User-Agent: nail 11.6pre 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Tested, sendfile(2) returns a short count if you send a signal to the
> calling process.

Fine, thank you. This makes it really useful.

> Add another loop in the userspace caller to deal with it, if you don't
> already have it. It's a valid and documented return value, after all.

Of course (although cp will be terminated by the SIGINT anyway, so it
does not matter in this situation).

Do I understand this correctly that sendfile now behaves like write with
SA_RESTART not set for the signal? If so, it might perhaps make sense to
add SA_RESTART semantics too, so that sendfile then just continues if the
process catches the signal and does not abort (scenario: SIGWINCH is sent
to a curses-based file manager).

	Gunnar

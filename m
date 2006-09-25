Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWIYEdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWIYEdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 00:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWIYEdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 00:33:40 -0400
Received: from mail.aknet.ru ([82.179.72.26]:27140 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751007AbWIYEdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 00:33:39 -0400
Message-ID: <45175C7B.7040005@aknet.ru>
Date: Mon, 25 Sep 2006 08:35:07 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Ulrich Drepper <drepper@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com> <45155499.4000209@redhat.com>            <45155707.4010906@aknet.ru> <200609250112.k8P1CTfZ019880@turing-police.cc.vt.edu>
In-Reply-To: <200609250112.k8P1CTfZ019880@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Valdis.Kletnieks@vt.edu wrote:
>> But why exactly? They do:
>> shm_open();
>> mmap(PROT_READ|PROT_WRITE|PROT_EXEC);
>> and mmap fails.
>> Where is the fault of an app here?
> Are you suggesting that it's not an app's fault/problem if it tries to
> open a writable file on a R/O filesystem?  Because it's essentially the
> same problem....
It is not really the same - the app is not trying to
create an "executable" file on a noexec filesystem.
PROT_EXEC never required the exec permission on a file
btw. The MAP_PRIVATE mmap roughly means a read of the
file into the memory, where the program can do anything
with its data, including an execution. Does the R/O
filesystem disallow PROT_WRITE for MAP_PRIVATE? Haven't
tried, but I hope it doesn't.


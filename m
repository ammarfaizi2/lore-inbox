Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTHTTHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTHTTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:07:12 -0400
Received: from hera.kernel.org ([63.209.29.2]:40884 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262151AbTHTTHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:07:09 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Date: Wed, 20 Aug 2003 12:06:34 -0700
Organization: OSDL
Message-ID: <bi0grq$49r$1@build.pdx.osdl.net>
References: <20030820171431.0211930e.martin.zwickel@technotrend.de> <20030820113625.6a75d699.akpm@osdl.org>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1061406394 4411 172.20.1.2 (20 Aug 2003 19:06:34 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 20 Aug 2003 19:06:34 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>>
>> Today I wanted to check out some src-files from cvs.
>>  But my fault was, that I ran cvs twice at the same time.
>> 
>>  so two "cvs upd -d -A" are now in 'D' state.
>> 
>>  I think they got stuck because both tried to access the same file.
> 
> How odd.  Were they the only processes which were in D state?

They are probably hung on the same semaphore, ie "dir->i_sem". They almost
certainly are not deadlocked on each other: something else has either left
the directory semaphore locked, or is in turn waiting for something else.

Martin - do you have the _full_ list of processes available?

                Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWA1QMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWA1QMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWA1QMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:12:00 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:32180 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751463AbWA1QL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:11:58 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, reiser@namesys.com
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Sat, 28 Jan 2006 18:11:35 +0200
User-Agent: KMail/1.8.2
References: <200601281613.16199.vda@ilport.com.ua> <200601281701.02533.vda@ilport.com.ua>
In-Reply-To: <200601281701.02533.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281811.35690.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing namesys]

Narrowed it down to 100% reproducible case:

	chown -Rc 0:<n> .

in a top directory of tree containing ~21938 files
on reiser3 partition:

	/dev/sdc3 on /.3 type reiserfs (rw,noatime)

causes oom kill storm. "ls -lR", "find ." etc work fine.

I suspected that it is a leak in winbindd libnss module,
but chown does not seem to grow larger in top, and also
running it under softlimit -m 400000 still causes oom kills
while chown's RSS stays below 4MB.
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUDNXNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUDNXKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:10:30 -0400
Received: from palrel11.hp.com ([156.153.255.246]:1998 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261982AbUDNWe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:34:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16509.48237.556502.218222@napali.hpl.hp.com>
Date: Wed, 14 Apr 2004 15:34:21 -0700
To: Jamie Lokier <jamie@shareable.org>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
In-Reply-To: <20040414210538.GG12105@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
	<20040414082355.GA8303@mail.shareable.org>
	<20040414113753.GA9413@mail.shareable.org>
	<16509.25006.96933.584153@napali.hpl.hp.com>
	<20040414184603.GA12105@mail.shareable.org>
	<16509.35554.807689.904871@napali.hpl.hp.com>
	<20040414192844.GD12105@mail.shareable.org>
	<16509.39308.8764.219@napali.hpl.hp.com>
	<20040414210538.GG12105@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 14 Apr 2004 22:05:38 +0100, Jamie Lokier <jamie@shareable.org> said:

  Jamie> David Mosberger wrote:

  >> No, Alpha Linux didn't map data without execute permission.

  Jamie> That was true from Linux 1.1.67 (when Alpha was introduced)
  Jamie> to 1.1.84 (when __[PS]* was introduced).  I'm not sure the
  Jamie> Alpha target even worked during those versions.  Since Linux
  Jamie> 1.1.84, it has mapped pages on the Alpha without execute
  Jamie> permission: the _PAGE_FOE (fault on exec) bit is set for
  Jamie> mappings which don't have PROT_EXEC.

$ uname -a
Linux hostname 2.2.20 #2 Wed Mar 20 19:57:28 EST 2002 alpha GNU/Linux
$ cat /proc/self/maps | grep cat
0000000120000000-0000000120006000 r-xp 0000000000000000 08:01 309740     /bin/cat
0000000120014000-0000000120016000 rwxp 0000000000004000 08:01 309740     /bin/cat

As you can see, the data-segment is mapped with EXEC bit turned on.
Ditto for the stack segment, which I think is this one:

000000011fffe000-0000000120000000 rwxp 0000000000000000 00:00 0

	--david

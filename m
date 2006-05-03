Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWECHDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWECHDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWECHDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:03:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37511 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964976AbWECHDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:03:20 -0400
Date: Wed, 3 May 2006 09:08:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.17-rc3-mm1] i386: break out of recursion in stackframe walk
Message-ID: <20060503070811.GC23921@elte.hu>
References: <20060502095034.GA21063@elte.hu> <16113.1146632636@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16113.1146632636@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Keith Owens <kaos@sgi.com> wrote:

> KDB just limits kernel traces to a maximum of 200 entries, which 
> catches direct as well as indirect recursion.  IA64 is notorious for 
> getting loops in its unwind data, sometime looping over three or four 
> functions.  Checking for a maximum number of entries is a simple and 
> architecture independent check.

you are right, but in this particular case this doesnt seem to be 
'wrong' unwind data, it's more of a special marker of the end of the 
frame (if i understood it correctly). If it's wrong unwind data then 
that data should be fixed.

I also agree with adding a limit to catch buggy cases of recursion, as a 
separate mechanism, independently of this particular bug.

	Ingo

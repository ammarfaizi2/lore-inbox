Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTANGdg>; Tue, 14 Jan 2003 01:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTANGdg>; Tue, 14 Jan 2003 01:33:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16290 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267463AbTANGdf>;
	Tue, 14 Jan 2003 01:33:35 -0500
Date: Mon, 13 Jan 2003 22:32:53 -0800 (PST)
Message-Id: <20030113.223253.18825371.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030114121012.63554a44.rusty@rustcorp.com.au>
References: <20030113072521.74B842C104@lists.samba.org>
	<20030112.233513.83403887.davem@redhat.com>
	<20030114121012.63554a44.rusty@rustcorp.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 14 Jan 2003 12:10:12 +1100

   Hmm, you really want to weakly align it: you don't care if something follows it on
   the cacheline, (ie. don't make it into an array, but it'd be nice if other
   things could share the cacheline) in UP.
   
No, that is an incorrect statement.

I want the rest of the cacheline to be absent of any write-possible
data.  There are many members in there which are read-only and thus
will only consume a cacheline which would never need to be written
back to main memory due to modification.

If you allow other things to seep into that cache line, you totally
obliterate what I was trying to accomplish.

   I don't think there's a way of doing that short of using asm?
   
You really don't understand what I'm trying to accomplish.

I want alignment on cache line boundary, and I don't want anything
else in that cacheline.

Franks a lot,
David S. Miller
davem@redhat.com

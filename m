Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267090AbUBRXLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267095AbUBRXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:11:33 -0500
Received: from dp.samba.org ([66.70.73.150]:29929 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267090AbUBRXJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:09:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.61622.732939.135127@samba.org>
Date: Thu, 19 Feb 2004 10:09:42 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<16433.47753.192288.493315@samba.org>
	<Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
	<16434.41376.453823.260362@samba.org>
	<c0uj52$3mg$1@terminus.zytor.com>
	<Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
	<4032D893.9050508@zytor.com>
	<Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
	<16435.55700.600584.756009@samba.org>
	<Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
	<Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
	<16435.60448.70856.791580@samba.org>
	<Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > Why do you focus on linear directory scans?

Because a large number of file operations are on filenames that don't
exist. I have to *prove* they don't exist. That includes:

 * every file create. I have to prove there wasn't an existing file
   under a different case combination.

 * every rename. Again, I have to prove that the destination name
   doesn't exist.

 * every open of a non-existant name (*very* common, its what MS
   office does all the time).

 etc etc.

If I had a single function that could quickly tell me that a file does
not exist in any case combination then I would be much better off.

 > They simply do not happen under any reasonable IO patterns. You look up 
 > names under the same name that they are on the disk. So the _only_ thing 
 > that should matter is the exact match.

nope, see above. The most common pattern of accesses involves doing a
full directory scan on every access.

 > Sure, I can imaging that MS would make some benchmark to show that case, 
 > but at that point I just don't care. 

It's not just "some benchmark". It's the normal use case.

Cheers, Tridge

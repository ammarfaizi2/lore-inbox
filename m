Return-Path: <linux-kernel-owner+w=401wt.eu-S964916AbWL1EcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWL1EcF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 23:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWL1EcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 23:32:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:52890 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917AbWL1EcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 23:32:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e4fXds4GqIFH5R/RP3cxo59ojVP5h03zqN5VHzZ46u9mlanyKxepWuk//1N7Ts3z6B2A/5kzJY+yUTafv7wUSKCqQpU613s4jlXHzzScKbcxab7DYAPZpw6cfPljzqEetY4oea4dHbyP9Sqhhz0jTT2K4/tBH3YdMBzuhVoWVf0=
Message-ID: <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
Date: Wed, 27 Dec 2006 21:32:00 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Cc: "David Miller" <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       "Andrew Morton" <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:

> [ Modified test-program that tells you where the corruption happens (and
>   when the missing parts were supposed to be written out) appended, in
>   case people care. ]

For the record, this is the output from a run on our ARM machine (32
MB RAM) with 2.6.18 + the following patches:

   mm: tracking shared dirty pages
   mm: balance dirty pages
   mm: optimize the new mprotect() code a bit
   mm: small cleanup of install_page()
   mm: fixup do_wp_page()
   mm: msync() cleanup

It is at all suprising that the second offset within a page can be
less than the first offset within a page ? e.g.

Chunk 260 corrupted (1-1455)  (2769-127)

$ ./linus-test
Writing chunk 279/280 (99%)
Chunk 256 corrupted (1-1455)  (1025-2479)
Expected 0, got 1
Written as (82)175(56)
Chunk 258 corrupted (1-1455)  (3945-1303)
Expected 2, got 3
Written as (56)51(20)
Chunk 260 corrupted (1-1455)  (2769-127)
Expected 4, got 5
Written as (20)30(18)
Chunk 262 corrupted (1-1455)  (1593-3047)
Expected 6, got 7
Written as (18)196(158)
Chunk 264 corrupted (1-1455)  (417-1871)
Expected 8, got 9
Written as (158)133(146)
Chunk 266 corrupted (1-1455)  (3337-695)
Expected 10, got 11
Written as (146)43(77)
Chunk 268 corrupted (1-1455)  (2161-3615)
Expected 12, got 13
Written as (77)251(211)
Chunk 270 corrupted (1-1455)  (985-2439)
Expected 14, got 15
Written as (211)257(231)
Chunk 272 corrupted (1-1455)  (3905-1263)
Expected 16, got 17
Written as (231)254(154)
Chunk 274 corrupted (1-1455)  (2729-87)
Expected 18, got 19
Written as (154)11(85)
Chunk 276 corrupted (1-1455)  (1553-3007)
Expected 20, got 21
Written as (85)230(134)
Chunk 278 corrupted (1-1455)  (377-1831)
Expected 22, got 23
Written as (134)233(103)
Checking chunk 279/280 (99%)

Gordon

-- 
Gordon Farquharson

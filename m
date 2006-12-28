Return-Path: <linux-kernel-owner+w=401wt.eu-S1752910AbWL1OPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbWL1OPf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 09:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbWL1OPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 09:15:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:59187 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbWL1OPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 09:15:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZkNEx9iu48qjKNLqHprbXblM64WHt+WxbNaA3d19ixxDS8izIRHz5kl7ikLact35BJqtExZLIfrlKJDFtwrQommoq3GKZv20dL1F7rZ5SiqSyWQJwqOvzMFY3EmZlIfHTFpxzwTE2/FKoepcRzObc/Fs0iYZ/ux1gQrKiSnmWUA=
Message-ID: <97a0a9ac0612280615y37a5661cg56c854fc9c780ebb@mail.gmail.com>
Date: Thu, 28 Dec 2006 07:15:29 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Gordon Farquharson" <gordonfarquharson@gmail.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "David Miller" <davem@davemloft.net>, ranma@tdiedrich.de,
       tbm@cyrius.com, "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       andrei.popa@i-neo.ro, "Andrew Morton" <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061228101311.GA9672@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
	 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
	 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
	 <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
	 <20061228101311.GA9672@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Fixing Linus' test program to pass nr & 255 to memset results in clean
> passes on 2.6.9 on TheCus N2100 (IOP8032x) and 2.6.16.9 StrongARM
> machines (as would be expected.)

Thanks for the fix, Russell.

I can now trigger the (real) problem by using a 25 MB file (100 << 18)
and the Linksys NSLU2 (ARM, IXP420 processor, 32 MB RAM).

$ ./linus-test
Writing chunk 17954/17955 (99%)
Chunk 514 corrupted (0-1459)  (872-2331)
Expected 2, got 0
Written as (8479)11160(10312)
Chunk 516 corrupted (0-303)  (3792-4095)
Expected 4, got 0
Written as (10312)10569(4426)
Chunk 959 corrupted (0-691)  (3404-4095)
Expected 191, got 0
Written as (687)4881(1522)
Chunk 1895 corrupted (0-1459)  (1900-3359)
Expected 103, got 0
Written as (7746)8389(6231)
Chunk 2702 corrupted (0-1459)  (472-1931)
Expected 142, got 0
Written as (4866)7103(2409)
Chunk 3314 corrupted (0-1459)  (1064-2523)
Expected 242, got 0
Written as (4287)7064(1730)
Chunk 4043 corrupted (0-1459)  (444-1903)
Expected 203, got 0
Written as (6495)8509(4464)
Chunk 5180 corrupted (0-1459)  (1584-3043)
Expected 60, got 0
Written as (11056)12826(10797)
Chunk 5672 corrupted (0-991)  (3104-4095)
Expected 40, got 0
Written as (9944)4872(41)
Chunk 5793 corrupted (460-1459)  (0-999)
Expected 161, got 0
Written as (7059)5038(4377)
Chunk 6089 corrupted (0-1459)  (1620-3079)
Expected 201, got 0
Written as (4672)5230(4403)
Chunk 6545 corrupted (268-1459)  (0-1191)
Expected 145, got 0
Written as (3701)5969(4668)
Chunk 7578 corrupted (0-1459)  (584-2043)
Expected 154, got 0
Written as (10015)5082(1648)
Chunk 7880 corrupted (864-1459)  (0-595)
Expected 200, got 0
Written as (17869)5064(4745)
Chunk 8086 corrupted (0-1459)  (888-2347)
Expected 150, got 0
Written as (10206)11050(10374)
Chunk 8749 corrupted (0-1459)  (2212-3671)
Expected 45, got 0
Written as (15263)7132(4825)
Chunk 9068 corrupted (0-1459)  (1008-2467)
Expected 108, got 0
Written as (5557)7571(6771)
Chunk 9193 corrupted (812-1459)  (0-647)
Expected 233, got 0
Written as (9238)7277(4757)
Chunk 10032 corrupted (576-1459)  (0-883)
Expected 48, got 0
Written as (15741)10012(1753)
Chunk 10056 corrupted (0-1459)  (1696-3155)
Expected 72, got 0
Written as (5379)7431(262)
Chunk 10395 corrupted (0-1459)  (1020-2479)
Expected 155, got 0
Written as (21)7442(5902)
Chunk 10791 corrupted (0-1459)  (1644-3103)
Expected 39, got 0
Written as (4753)5925(5926)
Chunk 10792 corrupted (0-991)  (3104-4095)
Expected 40, got 0
Written as (5925)5926(8555)
Chunk 11036 corrupted (0-1103)  (2992-4095)
Expected 28, got 0
Written as (13755)14449(7458)
Chunk 11387 corrupted (644-1459)  (0-815)
Expected 123, got 0
Written as (10853)11459(9445)
Chunk 11586 corrupted (920-1459)  (0-539)
Expected 66, got 0
Written as (3769)11691(11123)
Chunk 11882 corrupted (0-1459)  (1160-2619)
Expected 106, got 0
Written as (10736)11696(2788)
Chunk 12397 corrupted (0-603)  (3492-4095)
Expected 109, got 0
Written as (2352)7515(2437)
Chunk 12669 corrupted (0-795)  (3300-4095)
Expected 125, got 0
Written as (1191)7661(5266)
Chunk 13162 corrupted (0-1459)  (2184-3643)
Expected 106, got 0
Written as (9383)13662(11544)
Chunk 14653 corrupted (0-27)  (4068-4095)
Expected 61, got 0
Written as (8100)9456(1275)
Chunk 17332 corrupted (0-367)  (3728-4095)
Expected 180, got 0
Written as (760)12247(1244)
Chunk 17445 corrupted (0-1459)  (772-2231)
Expected 37, got 0
Written as (8007)16481(14439)
Chunk 17556 corrupted (0-1007)  (3088-4095)
Expected 148, got 0
Written as (10113)10657(10477)
Chunk 17859 corrupted (0-995)  (3100-4095)
Expected 195, got 0
Written as (14472)14767(11426)
Checking chunk 17954/17955 (99%)

Gordon

-- 
Gordon Farquharson

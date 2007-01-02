Return-Path: <linux-kernel-owner+w=401wt.eu-S1755284AbXABIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbXABIOJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbXABIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:14:09 -0500
Received: from smtp.nokia.com ([131.228.20.171]:58859 "EHLO
	mgw-ext12.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbXABIOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:14:08 -0500
Subject: Re: [PATCH] NAND: nandsim bad block injection
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Vijay Kumar <vijaykumar@bravegnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17815.54197.666735.904351@vaishnavi.localdomain>
References: <17810.36897.44930.853654@vaishnavi.localdomain>
	 <1167301341.4217.30.camel@sauron>
	 <17815.54197.666735.904351@vaishnavi.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Tue, 02 Jan 2007 10:13:37 +0200
Message-Id: <1167725617.20245.8.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 02 Jan 2007 08:13:38.0319 (UTC) FILETIME=[E7FE91F0:01C72E45]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 20:43 +0530, Vijay Kumar wrote:
> Artem Bityutskiy writes:
>  > 1. Suppose we decided to emulate an erase failure for a certain
>  > eraseblock. Then the MTD user re-tries the operation and succeeds.
>  > Shouldn't we start always returning erase errors for this eraseblock
>  > instead?
> 
> You are right. We should be mantaining the bad block state within the
> simulator. I will update the code accordingly.

Well, may be it is also useful to sporadically emulate errors which go
away after re-try.

>  > 2. In case of I/O errors, the correct MTD user should mark the bogus
>  > eraseblock bad. So, after some time we end up with most of our
>  > eraseblocks marked bad which is not very nice.
>  > 
>  > How would you comment this?
> 
> We can have an upper limit on the no. of blocks that can turn bad. It
> can be provided as a module parameter.

Yeah.

Also, one more nice feature would be to emulate bit-flips from time to
time. Just change one bit and let NAND level to fix it using ECC. This
would be good for testing both NAND layer and applications (MTD returns
-EUCLEAN in case of a bit flip, and applications should not panic in
this case - because the bit-flip was corrected). That's just an idea.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)


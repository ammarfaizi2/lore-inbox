Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWI2Od4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWI2Od4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWI2Od4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 10:33:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:6343 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750961AbWI2Odz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 10:33:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mNflWG6Dj42M0jAvNOtHBYSzMs8TV2/w1wLky+bk/yyNqKOGC2DYg+qQ4orM8gq42rxa4HxTXT6ICjguI1a3ZHTQrP0foGYybi6fzAmtJ8zxfGqTwjjkMJt1MiS07gXlemR+lpKVt/jz94l3kNOm2sIc+ubD9kF2NJ1P3FB/kSs=
Message-ID: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
Date: Fri, 29 Sep 2006 22:33:54 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Andi Kleen" <ak@suse.de>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dong Feng" <middle.fengdong@gmail.com>,
       "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>,
       "David Howells" <dhowells@redhat.com>
Subject: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I got a question, that is, I am confused by the following code in
do_sys_settimeofday().

if (tz) {
    /* SMP safe, global irq locking makes it work. */
        sys_tz = *tz;
        if (firsttime) {
            firsttime = 0;
            if (!tv)
                warp_clock();
    }
}


For my understanding, an assignment between structs should be a
bit-wise copy. Such operation is not atomic, so it can not be supposed
SMP-safe. And the subsequent test-and-assign operation on firsttime is
not atomic, either.

If the comments mean the subsequent code is SMP-safe and can prevent
nest-kernel-path, how does it achieves that?

Thank you in advance.
Feng,Dong

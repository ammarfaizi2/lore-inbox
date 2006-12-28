Return-Path: <linux-kernel-owner+w=401wt.eu-S1753904AbWL1XxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbWL1XxT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbWL1XxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:53:18 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:53778 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbWL1XxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:53:17 -0500
Date: Fri, 29 Dec 2006 00:52:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Want comments regarding patch
In-Reply-To: <1167331995.3281.4374.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0612290043050.23545@yvahk01.tjqt.qr>
References: <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com>
 <1167331995.3281.4374.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-273592685-1167349932=:23545"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-273592685-1167349932=:23545
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 28 2006 19:53, Arjan van de Ven wrote:
>On Thu, 2006-12-28 at 19:41 +0100, Daniel Marjamäki wrote:
>> Hello all!
>> 
>> I sent a patch with this content:
>> 
>> -       for (i = 0; i < MAX_PIRQS; i++)
>> -               pirq_entries[i] = -1;
>> +       memset(pirq_entries, -1, sizeof(pirq_entries));
>> 
>> I'd like to know if you have any comments to this change. It was
>> of course my intention to make the code shorter, simpler and
>> faster.
>
>personally I don't like the new code; memset only takes a byte as
>argument and while it probably is the same, that is now implicit
>behavior and no longer explicit. A reasonably good compiler will
>notice it's the same and generate the best code anyway, so I would
>really really suggest to go for the best readable code, which imo is
>the original code.

Then GCC is not a "reasonably good compiler". Considering

#define MAX 6400
struct foo {
    int line[MAX];
};
void bar(struct foo *a) {
    int i;
    for(i = 0; i < MAX; ++i)
        a->line[i] = -1;
}
void baz(struct foo *a) {
    __builtin_memset(a->line, -1, sizeof(a->line));
}

`gcc -O3 -c test.c` will generate a classic loop rather than a repz
movsd for bar(). baz() will get a call to an extern memset(),
probably because gcc could not figure out how to make a repz for it
and hence thought it was better to use an external hand-crafted
memset.


	-`J'
-- 
--1283855629-273592685-1167349932=:23545--

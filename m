Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWGHDyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWGHDyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWGHDyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:54:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:30082 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932505AbWGHDyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:54:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dIsPpFvFk9+NhxvDyhk8lDjW61mICzKPrItQb3xBauUUVqRQ0ruHq9PSdi9FhLN3C5ctRwpm+lBNqoYCtcA/UUr6wWOsClNf1xzdEtKz6xDiTyMjYcDa9GBlnb53B41wxIcaOpyligw8VEf/4PJVWhETzbhCK6OcPulQVkC/oVs=
Message-ID: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
Date: Fri, 7 Jul 2006 23:54:10 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> AND I POINTED OUT THAT EVEN IN YOUR TRIVIAL EXAMPLE, VOLATILE WAS
> ACTUALLY THE WRONG THING TO DO.
>
> And that's _exactly_ because the language environment (in this case
> the CPU itself) has evolved past the point it was 30 years ago.

Key thing being "language environment", meaning gcc.

By the language spec, volatile is a low-performance way to
get the job done. Following the language spec is damn hard
these days, considering some of the evil things PCI does in
the name of performance. The compiler probably should offer
an option to call a function for read/write to volatile mem.
Such a function could take a lock, determine if a PCI read
is required to enforce ordering, perform the operation, and
then release the lock.

That's all theoretical though. Today, gcc's volatile does
not follow the C standard on modern hardware. Bummer.
It'd be low-performance anyway though.

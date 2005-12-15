Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVLOPBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVLOPBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLOPBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:01:52 -0500
Received: from khc.piap.pl ([195.187.100.11]:13828 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750733AbVLOPBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:01:52 -0500
To: Dave Jones <davej@redhat.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
References: <20051214191006.GC23349@stusta.de>
	<20051214140531.7614152d.akpm@osdl.org>
	<20051214221304.GE23349@stusta.de>
	<9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com>
	<9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
	<20051215004006.GA19354@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 15 Dec 2005 16:01:44 +0100
In-Reply-To: <20051215004006.GA19354@redhat.com> (Dave Jones's message of
 "Wed, 14 Dec 2005 19:40:06 -0500")
Message-ID: <m3bqzijtev.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> Fedora has had this enabled most of the time for x86, x86-64, ia64,
> s390, s390x, ppc32 and ppc64 for a long time.  From time to time
> when a gcc bug has been tickled it's been disabled again until its
> been worked out, but for the most part, it's been a complete non-event
> wrt regressions.

BTW: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173764

gcc generates incorrect code with -Os (i386).

Version-Release number of selected component (if applicable):
gcc-4.0.1-4.fc4 and gcc-4.0.2-8.fc4 (i.e., FC4-current)

gcc -W -Wall -Os test.c -o test -Werror && ./test
array: 1 2
array: 1 2

gcc -W -Wall -O2 test.c -o test -Werror && ./test
array: 1 2
array: 2 3

Additional info:
Marked "high" as it miscompiles the Linux kernel.

#include <stdio.h>

void test_it(int *array)
{
	int i;

	for (i = 0; i < 2; i++) {
		int value = array[i];
		if (i != 1000 && i != 1001)
			array[i] = value + 1;
	}
}

int main(void)
{
	int array[2] = {1, 2};

	printf("array: %i %i\n", array[0], array[1]);

	test_it(array);

	printf("array: %i %i\n", array[0], array[1]);

	return 0;
}

-- 
Krzysztof Halasa

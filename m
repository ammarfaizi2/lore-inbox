Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129895AbRAEXjz>; Fri, 5 Jan 2001 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131035AbRAEXjq>; Fri, 5 Jan 2001 18:39:46 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:65319 "EHLO
	dai.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S129895AbRAEXja>; Fri, 5 Jan 2001 18:39:30 -0500
Message-ID: <3A565D71.4BA25E71@mclinux.com>
Date: Fri, 05 Jan 2001 18:49:05 -0500
From: Peng Dai <dai@mclinux.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0-test10ltt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Dai <dai@mclinux.com>
Subject: vmalloc and pkmap overlap on 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vmalloc pool runs from 0xf8000000 to FIXADDR_START,
which is a few pages below the top of virtual address space.

The pkmap area is from 0xfe000000 to 0xfe400000, which fits
within the vmalloc pool.

There does not seem to be any mechanism to prevent these two
from stepping on each other's toes. It could be fixed by, for
example, creating a  vm_struct that covers the pkmap area and
enlisting it to vmlist.

Thanks
Peng



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

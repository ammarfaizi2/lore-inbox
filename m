Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277813AbRJLTZX>; Fri, 12 Oct 2001 15:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277821AbRJLTZO>; Fri, 12 Oct 2001 15:25:14 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:23331 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277813AbRJLTZF>; Fri, 12 Oct 2001 15:25:05 -0400
Date: Fri, 12 Oct 2001 14:25:30 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups
In-Reply-To: <Pine.LNX.4.33.0110121340140.17295-100000@lists.us.dell.com>
Message-ID: <Pine.LNX.3.96.1011012141846.6594C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like it.  I even had local patches that did something similar,
creating lib/crc32, but it never got to the polished stage.  Donald
Becker had also suggested at the 2.5 kernel summit that the ether_crc
stuff become generic code, so your code here follows along well with
that plan.  So, after some testing, I'm definitely interested in these
patches (at least as they related to net drivers).

WRT initialization, I would suggest refcounting:  driver calls
init_crc32 at module load time, and cleanup_crc32 at module removal
time.  When the first reference appears, the desired poly table
is initialized.  When the last reference disappears, the poly table
is kfree'd.  I considered other initialization scenarios but this seems
to be the cleanest.

	Jeff




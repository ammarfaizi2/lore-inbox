Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVJCH12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVJCH12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVJCH12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:27:28 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:14808 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S932170AbVJCH11 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:27:27 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Shared library holes in x86_64
Date: Mon, 3 Oct 2005 12:57:17 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE9168367@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: Shared library holes in x86_64
Thread-Index: AcXH6qR6GWAPK4uNRBKKHWabNwx7CAAADdug
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: "Jakub Jelinek" <jakub@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Oct 2005 07:27:26.0137 (UTC) FILETIME=[E7472A90:01C5C7EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jakub...

I didn't get the exact reason in the previous thread...so rephrased my
question to make it more specific this time.

> x86-64 binaries and shared libraries are required to handle page sizes
up
> to 1MB and as RE and RW segments can't be on the same page, this means
they 
> must not share the same 1MB page.

This is what I was looking at...

Thanks a lot.

-Arijit


-----Original Message-----
From: Jakub Jelinek [mailto:jakub@redhat.com] 
Sent: Monday, October 03, 2005 12:48 PM
To: Arijit Das
Cc: linux-kernel@vger.kernel.org
Subject: Re: Shared library holes in x86_64

On Mon, Oct 03, 2005 at 12:00:05PM +0530, Arijit Das wrote:
> If I strace a "/bin/sleep 23" command in a RHAS3.0/x86-AMD64 machine,
I
> see that holes are being created in some of the mapped shared
libraries
> using the mprotect system call like this:

I explained it 3 days ago, so once again:
x86-64 binaries and shared libraries are required to handle page sizes
up
to 1MB and as RE and RW segments can't be on the same page, this means
they
must not share the same 1MB page.
Just google for ELF_MAXPAGESIZE or look at the libraries using readelf
-Wl.

	Jakub

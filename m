Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbRGBEZL>; Mon, 2 Jul 2001 00:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266364AbRGBEZB>; Mon, 2 Jul 2001 00:25:01 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:21204 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266363AbRGBEYs>; Mon, 2 Jul 2001 00:24:48 -0400
Date: Mon, 2 Jul 2001 00:24:45 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: hang from HUP'ing init in linuxrc
In-Reply-To: <15167.61332.139916.158874@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0107020017510.9798-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001, Paul Mackerras wrote:

> I'm not sure what the best way to fix this is.  The problem would crop
> up whenever we have a kernel thread which wants to wait for a child
> process.  I don't think we want to start delivering signals to kernel
> threads in the same way that we do to usermode processes though.
>
> Any suggestions?

Well, linuxrc and a number of aspects of the boot process seem to suffer
from attempting to kludge userspace programs into the kernel.  To this
end, I would like to propose that we move these functions into userspace
where they belong and instead provide support for linking an initial
filesystem image into vmlinux.  We can then move linuxrc, dhcp and other
such bits out of the kernel and use the same code as is normally used at
run time -> it's better tested and easier to fix.

		-ben


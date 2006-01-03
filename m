Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWACBGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWACBGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 20:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWACBGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 20:06:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:6028 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751148AbWACBGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 20:06:35 -0500
Subject: Re: Ping-Pong Compatible DMA buffer chaining
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Deven Balani <devenbalani@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0512252205t68c6b6f6sfeedf3a75880fda9@mail.gmail.com>
References: <7a37e95e0512252205t68c6b6f6sfeedf3a75880fda9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 01:08:40 +0000
Message-Id: <1136250520.13968.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-26 at 11:35 +0530, Deven Balani wrote:
> 1) The SATA Host Controller supports a DMA Logic which has Ping Pong Buffers.
> How Can I allocate a linear contiguous buffer and give it to the
> Buffer Descriptors of the Host Controller. I believe consistent alloc
> would help me in this regard. But How could I do a chaining of Buffers
> in a Ping Pong Scenario which has Buffer Descriptors.

Depends entirely on your hardware.

> 2) The libata is using Scatter-Gather List to send Device Identify
> Command. Is it necessary to have a Scatter-Gather List for non-PCI ARM
> platforms. Can I bypass this mechanism.

It is neccessary as the user space virtual memory will be fragmented in
physical space (unless you are using MMUless Linux when it will be far
less fragmented).

If the platform is an MMUless one then you can fill in the host
structure and indicate that you support a maximum scatter gather list
size of one. This will break up I/O's when neccessary to keep within
that limit but this will hurt your performance by causing a lot more
requests on a non MMUless system.

Alan


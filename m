Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUIHEQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUIHEQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUIHEQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:16:36 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3266 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268756AbUIHEPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:15:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: multi-domain PCI and sysfs
Date: Tue, 7 Sep 2004 21:15:09 -0700
User-Agent: KMail/1.7
Cc: Jon Smirl <jonsmirl@gmail.com>, willy@debian.org,
       linux-kernel@vger.kernel.org
References: <9e4733910409041300139dabe0@mail.gmail.com> <9e47339104090715585fa4f8af@mail.gmail.com> <20040907161140.29fbfccc.davem@davemloft.net>
In-Reply-To: <20040907161140.29fbfccc.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409072115.09856.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 7, 2004 4:11 pm, David S. Miller wrote:
> This is a real touchy area btw, because if there is no
> VGA card, such I/O port accesses are going to trap and
> we need to have a common way to handle that somehow.

So I take it your platform won't soft fail the accesses and return all 1s?  On 
ia64, I've got a patch to add some machine check code to deal with it, but it 
requires pre-registration of the regions that are to be used for legacy I/O 
(i.e. I have to record the memory range and pid at /proc/bus/pci mmap time so 
that the machine check handler can send a SIGBUS).  A potentially cleaner 
option which Ben and I would prefer is to use the vga device Jon is creating 
to do legacy I/O with explicit read/write or ioctl calls.

Jesse

Return-Path: <linux-kernel-owner+w=401wt.eu-S1751425AbXARPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXARPbW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXARPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:31:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:29681 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXARPbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:31:21 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dvK2/h/BXmUeYzqNanwTlj6Agih/mF95DTogbCF0YphPt8rqk8xUbd+2RmYuaYm/Oo0qnBetrduww7pro03JLSu4Nsj4VDhfGrZwCYlgd3zMHWA3iBlIxgcbJJvOnBw8qetEKmJ0eK6yVedanlzV4JyiZU6UfJv8qwFZCb0GEvQ=
Message-ID: <9e0cf0bf0701180731s38188de7w6e3648526339ad5b@mail.gmail.com>
Date: Thu, 18 Jan 2007 17:31:18 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Tomas Carnecky" <tom@dbservice.com>, "Bernhard Walle" <bwalle@suse.de>,
       linux-kernel@vger.kernel.org, "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
In-Reply-To: <20070118152326.GC31418@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070118125849.441998000@strauss.suse.de>
	 <20070118130028.719472000@strauss.suse.de>
	 <20070118141359.GB31418@flint.arm.linux.org.uk>
	 <45AF92E7.50901@dbservice.com>
	 <20070118152326.GC31418@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> If you want to place a variable in a specific section, it must be
> explicitly initialised.  Eg,
>
> static char __initdata command_line[COMMAND_LINE_SIZE] = "";
>
> However, there is a bigger question here: that is the tradeoff between
> making this variable part of the on-disk kernel image, but throw away
> the memory at runtime, or to leave it in the BSS where it will not be
> part of the on-disk kernel image, but will not be thrown away at
> runtime.

This patch is a result of trying to extend the kernel command-line
size on x86 to more than 256 bytes. People requested to not allocate a
larger buffers for small systems.

I don't know who should decide the tradeoff...

So what you basically say is that many modules need to be fixed...
./arch/avr32/boards/atstk1000/setup.c
./arch/frv/kernel/setup.c
./arch/i386/kernel/acpi/boot.c
./arch/i386/kernel/mpparse.c
./arch/i386/kernel/setup.c
./arch/ia64/kernel/setup.c
<many more>

Best Regards,
Alon Bar-Lev.

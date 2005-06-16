Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVFPMcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVFPMcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 08:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVFPMcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 08:32:18 -0400
Received: from alog0370.analogic.com ([208.224.222.146]:52905 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261649AbVFPMcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 08:32:13 -0400
Date: Thu, 16 Jun 2005 08:31:53 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: guorke <gourke@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mabye simple,but i confused
In-Reply-To: <d73ab4d005061522254f2e5933@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0506160819350.29979@chaos.analogic.com>
References: <d73ab4d005061522254f2e5933@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, guorke wrote:

> in understangding the linux kernel, the authors says
> "..Moves itself from address 0x00007c00 to address 0x00090000.."
>
> What i confused is why the Boot Loader do this, i asked google,but
> still no answe.
> who can make me understand it ?
> Thanks.

The IBM 'IPL' (initial program load) address was specified to be
at 7c00. There was room here for only one "sector", which in the
early days was 512 bytes. The very first sector, the boot sector,
was loaded into this address and then execution was started at
a specified offset so that this boot code could load the rest
of the operating system. To load the rest of the operating system,
one needs to move the boot-code to somewhere it won't get
overwritten by subsequent reads from the disk.

To load Linux, the boot developers wanted to load code 64k at
a time. The only address in real-mode, that was guaranteed to
not be in use, where the boot code could load a whole 64k was
at 90000 hex. This provides a buffer from which the boot-loader
can copy 64k at a time into the protected-mode address space
starting at 0x00100000. The boot-loader uses real-mode BIOS
services to copy the code to the 1 megabyte address which can't
be reached in real mode.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

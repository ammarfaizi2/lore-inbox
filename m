Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293602AbSCUIWh>; Thu, 21 Mar 2002 03:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293589AbSCUIW2>; Thu, 21 Mar 2002 03:22:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10252 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293552AbSCUIWQ>;
	Thu, 21 Mar 2002 03:22:16 -0500
Message-ID: <3C999802.6020906@mandrakesoft.com>
Date: Thu, 21 Mar 2002 03:21:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Kittenberger <Axel.Kittenberger@maxxio.at>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Patch, forward release() return values to the close() call
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Kittenberger wrote:

>Here goes my liitle patchy, once again :o)
>
>Whats it's about?
>
>When close()ing an charcter device one expects the return value of the 
>charcter drivers release() call to be forwarded to the close() called in 
>userspace. However thats not the case, the kernel swallows the release() 
>value, and always returns 0 to the userspace's close(). (tha char drivers 
>release() function is called in fput() as it would have a void return value)
>
>It may sound weired at first but there are actually device drivers than can 
>fail on close(), in my case it's a driver to program a LCA, the userspace 
>application signals end of data by closing the device, the driver finalizes 
>the download, and the LCA reports if it has accepted it's new program, if not 
>close() should return a non-zero value, indicating the operation did not 
>complete successfully.
>

Note also that the Single Unix Specification v3 says that the state of 
the filedes is undefined.  If your applications are relying on such 
fail-on-close(2) behavior that keeps the file descriptor completely 
intact, they are non-standard at best, buggy at worst.

    Jeff







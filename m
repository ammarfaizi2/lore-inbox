Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUFGJ5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUFGJ5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUFGJ5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:57:43 -0400
Received: from main.gmane.org ([80.91.224.249]:2468 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264382AbUFGJ5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:57:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Date: Mon, 07 Jun 2004 10:58:29 +0100
Message-ID: <ca1e68$5p1$1@sea.gmane.org>
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org> <20040605001832.GA28502@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.mev.co.uk
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
In-Reply-To: <20040605001832.GA28502@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2004 01:18, Greg KH wrote:
> On Fri, Jun 04, 2004 at 05:34:41PM +0100, Ian Abbott wrote:
>>A related problem with the current implementation is that is easy to 
>>run out of memory by running something similar to this:
>>
>> # cat /dev/zero > /dev/ttyUSB0
>>
>>That affects both the ftdi_sio and visor drivers.
> 
> 
> Care to try out the following (build test only) patch to the visor
> driver to see if it prevents this from happening?  I don't have a
> working visor right now to test it out myself :(

I could try something similar on ftdi_sio, but am a bit pushed for 
time right now.

One comment about the test patch in case it turns into a real patch: 
I think it would be better to check the number of outstanding write 
urbs in visor_write_room instead of visor_write, otherwise some 
stuff written by the TTY line discipline will go missing.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-


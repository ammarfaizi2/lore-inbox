Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUJDOXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUJDOXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUJDOXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:23:23 -0400
Received: from relay.pair.com ([209.68.1.20]:62213 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267951AbUJDOQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:16:41 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <41615B48.904@cybsft.com>
Date: Mon, 04 Oct 2004 09:16:40 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: Bug#274860: Acknowledgement (kernel-image-2.6.8-1-686: CDROM_SEND_PACKET
 ioctls only work as root)
References: <E1CES9w-0005Lh-6f@lkcl.net> <handler.274860.B.10968930694757.ack@bugs.debian.org> <20041004131014.GF19341@lkcl.net> <20041004135326.GA20930@lkcl.net> <20041004140145.GY2287@suse.de>
In-Reply-To: <20041004140145.GY2287@suse.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Oct 04 2004, Luke Kenneth Casson Leighton wrote:
> 
>>found it.
>>
>>it's a new piece of kernel code verify_command in
>>drivers/block/scsi_ioctl.c, which checks for the capability
>>CAP_SYS_RAWIO.
>>
>>ah, dammit.
>>
>>for k3b to work, you'd have to install it setuid root, call
>>getcap(), remove all but the necessary capabilities (i.e. don't
>>remove CAP_SYS_RAWIO), do a setfsuid() and setfsgid() and do
>>a setcap().
> 
> 
> it works in 2.6.9-rcX.
> 

I don't know for sure if this is related or not, but it sure sounds like 
it. I have noticed the following in at least the last few versions (I 
believe 2.6.9-rc2 also): Even though CONFIG_SECURITY_CAPABILITIES can be 
configured as a module, if I don't compile it into the kernel getcap and 
setcap fail.

kr

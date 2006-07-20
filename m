Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWGTX3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWGTX3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWGTX3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:29:03 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:40557 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030411AbWGTX3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:29:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VGTnDf1geU/bM1bLwklTSlCH982BElShvNhuRa+CNvYwZAcUmExtZz3BXG6b2lw9HVZ9ddwbFkX9OAcvZRs27LZIABOZ8WVwQ9CT8Ec19EVJ2tq47mB4Zperk4IcRlm9Xrsv3dD+XLNaiwRIDKfQF1LBR8yVff4lAGQO+hvSm4I=
Message-ID: <44C011B3.3060900@gmail.com>
Date: Fri, 21 Jul 2006 07:28:51 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Kalev Lember <kalev@smartlink.ee>
CC: Gerd Hoffmann <kraxel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kexec and framebuffer
References: <44BB9A7A.4060100@smartlink.ee> <44BB9EB3.9020101@suse.de> <44BFEAA5.5030703@smartlink.ee>
In-Reply-To: <44BFEAA5.5030703@smartlink.ee>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalev Lember wrote:
> Gerd Hoffmann wrote:
>>> I am wondering what would be the preferred method to extract screen_info
>>> from running kernel. Should this be made available from sysfs or maybe a
>>> new system call be created?
>>>     
>> Simply ask /dev/fb0?
>> Patch for kexec tools attached.
>>   
> Thank you, this was really helpful.
>> +	if (0 != strcmp(fix.id, "vesafb"))
>> +		goto out;
> I think this check should be removed so that other framebuffer drivers
> besides vesafb would also work.

I think having the check is correct, only vesafb relies totally on
screen_info. If you remove the check, you can get the wrong information
from other framebuffer drivers.

> +	/* fixme: better get size from /proc/iomem */
> +	real_mode->lfb_size       = (fix.smem_len + 65535) / 65536;
> +	real_mode->pages          = (fix.smem_len + 4095) / 4096;

Note that fix.smem_len is the size of the remapped memory which can be
smaller than the actual framebuffer length. But there's a fixme comment
there so you probably know about this.
 
> Additionally the fix.id is "VESA VGA",
> not "vesafb".

Yes.

Tony

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270325AbUJTMgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbUJTMgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUJTMdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:33:55 -0400
Received: from neopsis.com ([213.239.204.14]:60545 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S267668AbUJTMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:31:16 -0400
Message-ID: <41765A8C.2020309@dbservice.com>
Date: Wed, 20 Oct 2004 14:31:08 +0200
From: Tomas Carnecky <tom@dbservice.com>
Organization: none
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org>
In-Reply-To: <200410201318.26430.oliver@neukum.org>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch, 20. Oktober 2004 00:10 schrieb Tomas Carnecky:
> 
>>I think this would make the suspend/resume/access/switching etc problems 
>>much easier to solve since the kernel module could tell the library to 
>>stop drawing/accessing mmap'ed memory etc. (or if the OpenGL rendering 
>>is done in the kernel module it could just discard the render commands).
>>Since the user has no direct access to mmap'ed memory and other critical 
>>sections of the device, the driver can implement proper power managment 
>>for suspend/resume etc.
>>
>>Well... that's it.. any comments? I'm sure you have.. :)
> 
> 
> You are making damn sure that there will be no useful bug reports
> about problems with resuming from S3.
> 

I guess that you are talking about the fact that displaying text 
messages would be possible only after the first device driver has 
initialized and registered with the kernel.

You could do the printing in two stages: at the begining the same way as 
in the current kernel, but as soon as the first driver is registered, 
the kernel switches to the function provided by the driver.

Something like this:

void print_message(...)
{
    if (no_module_registered) {
       use_print_function_provided_by_the_kernel();
    } else {
       if (!printing_disabled) {
          use_print_function_provided_by_the_driver_module();
       } else {
          /* printing disabled by the userspace, we are not
           * allowed to touch the hardware */
       }
    }
}

tom

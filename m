Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUJFRM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUJFRM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJFRM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:12:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5006 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266547AbUJFRKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:10:33 -0400
Message-ID: <41642703.8030700@redhat.com>
Date: Wed, 06 Oct 2004 13:10:27 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Kilian <kilian@bobodyne.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Solaris developer wants a Linux Mentor for drivers.
References: <200410061625.i96GPVu01974@raceme.attbi.com>
In-Reply-To: <200410061625.i96GPVu01974@raceme.attbi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Kilian wrote:
> 
>   Kernel folks,
> 
>     I am in the process of porting a Sun Solaris PCI bus driver
>     that I wrote over to a 2.4 kernel, and I could use a mentor
>     just to get me over the initial bumps.
> 
>     I have a module that can be loaded, and detects my card, and
>     responds to ioctl() calls properly, so I'm moving right along,
>     but I do have some problems now.
> 
>     1) If I "oops" in my module, I cannot unload it with:
>        # /sbin/rmmod sse    
>        sse: Device or resource busy
somebody is holding a reference to your device, either through your 
modules use of the MOD_INC_USE_COUNT macro (which I believe is 
depricated), or through the use of one of the macros that the kernel 
uses to prevent module remove race conditions (dev_hold is the only one 
that jumps to mind at the moment).  You can only get the module to 
remove by balancing the MOD_INC/DEC macros, or massaging your kernel to 
release any references to your module.  However, after an oops, its 
usually best practice to reboot, lest you run a kernel with corrupted 
memory somewhere.

> 
>        I have only figured out that a reboot cleans things up again.
> 
>     2) An example of using pci_ops read_dword() would be superb.
> 
I don't believe you call the operation in a pci_ops structure directly. 
  check the kernel for references to 
pci_[read|write]_config_[byte|word|dword] instead.

HTH
Neil
>     By the way, this development environment is really slick
>     compared to Solaris. When I "oops" in Solaris, the kernel
>     panics and I'm in for a messy fsck on the way back up. This
>     is a great improvement.
> 
>     Thanks in advance for any help any of you may provide.
> 
>     After this, there will be one more Linux PCI bus driver developer
>     in the world, and that can't be a bad thing.
> 
>                           -Alan
> 


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/

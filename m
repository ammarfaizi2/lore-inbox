Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUHYOST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUHYOST (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHYOST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:18:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33736 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267523AbUHYOSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:18:18 -0400
Message-ID: <412C9F89.7000901@pobox.com>
Date: Wed, 25 Aug 2004 10:17:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Ludvig <mludvig@suse.cz>
CC: Michael Halcrow <mahalcro@us.ibm.com>,
       CryptoAPI List <cryptoapi@lists.logix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/crypto for Linux
References: <412BB517.4040204@suse.cz> <20040824215351.GA9272@halcrow.us> <412C41BC.8020607@suse.cz>
In-Reply-To: <412C41BC.8020607@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What is it good for?
> One can build really light-weigth programs with crypto support that
> don't need any external libraries (e.g. OpenSSL) or built-in algorithms.
> Easier testing of new CryptoAPI ciphers (later also hashes and maybe
> asymmetric ciphers as well).
> Once, maybe, userspace access to crypto accelerators through kernel
> drivers.


Let's see...

1) This increases context switches over a solution that links with 
libcrypto and libssl.

2) "build really lightweight programs with crypto support" implies that 
you think it's a benefit to use the kernel as your crypto lib.  Shared libs

3) Your proposal actually avoids existing, working hardware crypto 
support such as Broadcom's hwcrypto driver which is fully supported by 
openssh.

4) "open it and use ioctls to transfer data" is typically a bad idea. 
ioctl(2) is a historical Unix mistake, to be avoided where possible. 
read(2)/write(2) are to be used to transfer data.

	Jeff




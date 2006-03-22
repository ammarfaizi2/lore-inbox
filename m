Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWCVQFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWCVQFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWCVQFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:05:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:19912 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750781AbWCVQFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:05:53 -0500
Message-ID: <442175BA.6000207@zytor.com>
Date: Wed, 22 Mar 2006 08:05:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Michael Neuling <mikey@neuling.org>, klibc@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       miltonm@bga.com, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [klibc] Re: [PATCH] initramfs: CPIO unpacking fix
References: <20060216183745.50cc2bf6.mikey@neuling.org>	<20060217160621.99b0ffd4.mikey@neuling.org>	<20060322061220.8414067A70@ozlabs.org> <4420F93C.1050705@garzik.org>
In-Reply-To: <4420F93C.1050705@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> For the kernel, I would regard that as needless code...  Coding for a 
> chain of CPIO archives overwriting each other seems like overengineering.
> 

No, it's actually significant.  The ability to compose initramfs 
contents from multiple sources is one of the major improvements over initrd.

For example, people has asked that kinit should be able to be called 
from user-provided (initrd-loaded) initramfs code.  The easiest way to 
do that is to have the in-kernel module have:

	/init -> /kinit
	/kinit

... and allow /init to be overwritten.

	-hpa

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUCPCSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbUCPCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:15:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:28371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263415AbUCPCOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:14:03 -0500
Date: Mon, 15 Mar 2004 18:14:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Kenneth Chen" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch - make config_max_raw_devices work
Message-Id: <20040315181406.2f2d8f38.akpm@osdl.org>
In-Reply-To: <200403160053.i2G0rNm31241@unix-os.sc.intel.com>
References: <200403160053.i2G0rNm31241@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
>
> Even though there is a CONFIG_MAX_RAW_DEVS option, it doesn't actually
>  increase the number of raw devices beyond 256 because during the char
>  registration, it uses the standard register_chrdev() interface which
>  has hard coded 256 minor in it.  Here is a patch that fix this problem
>  by using register_chrdev_region() and cdev_(init/add/del) functions.

Badari wrote basically the same patch a couple of months back.  I dropped
it then, too ;)

raw is a deprecated interface and if we keep on adding new features to it,
we will never be rid of the thing.  If your application requires more than
256 raw devices, please convert it to open the block device directly,
passing in the O_DIRECT flag.


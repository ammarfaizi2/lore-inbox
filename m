Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTKUReu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTKUReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:34:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:48580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264382AbTKURes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:34:48 -0500
Date: Fri, 21 Nov 2003 09:40:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: <dhruv.anand@wipro.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, janetinc@us.ibm.com,
       pbadari@us.ibm.com, nathans@sgi.com
Subject: Re: DIRECT IO for ext3/ext2.
Message-Id: <20031121094035.1e00b176.akpm@osdl.org>
In-Reply-To: <1E27FF611EBEFB4580387FCB5BEF00F3013DEEE8@blr-ec-msg04.wipro.com>
References: <1E27FF611EBEFB4580387FCB5BEF00F3013DEEE8@blr-ec-msg04.wipro.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<dhruv.anand@wipro.com> wrote:
>
> 
> Hi,
> I am working on an application on linux-2.6 that needs to
> bypass the buffer cache. In order to do so i use the direct
> IO functionality. Although open to the device succeeds with
> the DIRECT_IO flag, read from the device fails.
> 
> Following is the exceprt fromt he code to open and read;
> --------------------------------------------------------
> 
> if ((devf = open(dumpdev, O_RDONLY | O_DIRECT, 0)) < 0) {
>      fprintf(KL_ERRORFP, "Error: open failed!\n");
>      ...
> }
> 
> if(err = read(devf, &magic_nr, sizeof(magic_nr)) != sizeof(magic_nr)) {
>      fprintf(KL_ERRORFP, "Error: read() failed!\n");
>       ...
> }
> 
> ---------------------------------------------------------
> I am returned an errno=22, indicating 'Invalid argument'
> 

O_DIRECT reads must be aligned to the filesystem blocksize.  Both the
memory address and the file offset must be thus aligned.


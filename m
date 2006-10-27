Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946390AbWJ0LGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946390AbWJ0LGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946389AbWJ0LGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:06:39 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:44604 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1946390AbWJ0LGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:06:38 -0400
Date: Fri, 27 Oct 2006 13:06:37 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to run an a.out file in a kernel module
Message-ID: <20061027110636.GA2837@harddisk-recovery.com>
References: <20061027101611.67643.qmail@web27406.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027101611.67643.qmail@web27406.mail.ukl.yahoo.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 11:16:11AM +0100, ranjith kumar wrote:
>           How to run an a.out file in a kernel module
>              I tried to include
>                                     system("./a.out");
>      in the C file. But I got compilation errors.

Simple: you don't. There are a bunch of problems over here:

1) The system() call is a userland libc call and doesn't exist in the
   kernel
2) You can't be sure you're in user context
3) You don't know in what filesytem namespace you are

You could use call_usermodehelper() if you really need to call a
usermode helper, but usually it's a sign of bad design if you need to.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

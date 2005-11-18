Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbVKRLaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbVKRLaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161064AbVKRLaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:30:09 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:42506 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1161054AbVKRLaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:30:07 -0500
Message-ID: <437DBB2B.3030006@shadowen.org>
Date: Fri, 18 Nov 2005 11:29:47 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <sfrench@samba.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       samba-technical@samba.org
Subject: Re: 2.6.15-rc1-mm2
References: <20051117234645.4128c664.akpm@osdl.org>
In-Reply-To: <20051117234645.4128c664.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> - cifs is busted when built as a module.  Mysteriously.

Don't know if this is related, but it appears that there is a problem
linking it static.  Specifically when you enable CONFIG_CIFS but not
CONFIG_CIFS_XATTR.  It seems that get_sfu_uid_mode() uses
CIFSSMBQueryEA() which is only available when CIFS_XATTR is defined.
Oddly the error seems to be reported against the function which follows:

  fs/built-in.o(.text+0x131520): In function `.cifs_get_inode_info':
  : undefined reference to `.CIFSSMBQueryEA'
  make: *** [.tmp_vmlinux1] Error 1

-apw

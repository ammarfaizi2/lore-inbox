Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWCUE2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWCUE2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWCUE2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:28:48 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:44779 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1030285AbWCUE2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:28:48 -0500
Message-ID: <441F80E3.6090308@cfl.rr.com>
Date: Mon, 20 Mar 2006 23:28:19 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: dreiners@iastate.edu, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net>
In-Reply-To: <20060320134533.febb0155.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why on earth does linux enforce this restriction?  I'm not sure about dos ( it has been 10+ years since I used it ), but NT will happily create files with those names on either fat or ntfs, provided that you refer to them with an absolute path name.  Seeing as how it wasn't really a restriction on the filesystem itself, but rather the fact that those names were predefined by io.sys, I see no reason why linux should prevent you from using them.  

Randy.Dunlap wrote:
> "AUX" is (was) a reserved "filename" in DOS.  The Linux MS-DOS
> filesystem preserves (protects) that.  The extension part does not
> matter; it only checks the first 8 characters of the filename.
> You'll need to use a different filesystem or filename...
> 
> 
> fs/msdos/namei.c:
> 
> 		for (reserved = reserved_names; *reserved; reserved++)
> 			if (!strncmp(res, *reserved, 8))
> 				return -EINVAL;
> 
> /* MS-DOS "device special files" */
> static const unsigned char *reserved_names[] = {
> 	"CON     ", "PRN     ", "NUL     ", "AUX     ",
> 	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
> 	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
> 	NULL
> };
> 
> 


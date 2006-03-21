Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWCUFWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWCUFWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWCUFWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:22:52 -0500
Received: from xenotime.net ([66.160.160.81]:62140 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030322AbWCUFWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:22:52 -0500
Date: Mon, 20 Mar 2006 21:24:59 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: dreiners@iastate.edu, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
Message-Id: <20060320212459.5b0733f3.rdunlap@xenotime.net>
In-Reply-To: <441F80E3.6090308@cfl.rr.com>
References: <1142890822.5007.18.camel@localhost.localdomain>
	<20060320134533.febb0155.rdunlap@xenotime.net>
	<441F80E3.6090308@cfl.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 23:28:19 -0500 Phillip Susi wrote:

> Why on earth does linux enforce this restriction?  I'm not sure about dos ( it has been 10+ years since I used it ), but NT will happily create files with those names on either fat or ntfs, provided that you refer to them with an absolute path name.  Seeing as how it wasn't really a restriction on the filesystem itself, but rather the fact that those names were predefined by io.sys, I see no reason why linux should prevent you from using them.  

The only reason that I could come close to seeing is backwards
compatibility:  moving a disk+filesystem back to a real DOS
environment.  But that's just not very likely...


> Randy.Dunlap wrote:
> > "AUX" is (was) a reserved "filename" in DOS.  The Linux MS-DOS
> > filesystem preserves (protects) that.  The extension part does not
> > matter; it only checks the first 8 characters of the filename.
> > You'll need to use a different filesystem or filename...
> > 
> > 
> > fs/msdos/namei.c:
> > 
> > 		for (reserved = reserved_names; *reserved; reserved++)
> > 			if (!strncmp(res, *reserved, 8))
> > 				return -EINVAL;
> > 
> > /* MS-DOS "device special files" */
> > static const unsigned char *reserved_names[] = {
> > 	"CON     ", "PRN     ", "NUL     ", "AUX     ",
> > 	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
> > 	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
> > 	NULL
> > };

---
~Randy

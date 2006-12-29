Return-Path: <linux-kernel-owner+w=401wt.eu-S964927AbWL2Ft5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWL2Ft5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbWL2Ft5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:49:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:49246 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbWL2Ft4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:49:56 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: open /dev/kvm: No such file or directory
Date: Fri, 29 Dec 2006 06:50:27 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dor Laor <dor.laor@qumranet.com>,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com> <b6a2187b0612280742x1b613849ye23aca38c71a5871@mail.gmail.com> <4593E7EB.7070801@argo.co.il>
In-Reply-To: <4593E7EB.7070801@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612290650.28508.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 16:51, Avi Kivity wrote:
> Greg, /dev/kvm is a MISC_DYNAMIC_MINOR device.  Is there any way of
> using it without udev?  Should I allocate a static number?

You can write a small script that parses /proc/misc and creates the device,
like

# /sbin/mknod /dev/kvm c 10 `grep '\<kvm\>' /proc/misc | cut -f 1 -d\ `

If you already have an init script, e.g. to set up tun/tap devices,
it would make sense to put it in there.

	Arnd <><

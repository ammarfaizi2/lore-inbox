Return-Path: <linux-kernel-owner+w=401wt.eu-S932593AbWLaOOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWLaOOH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 09:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbWLaOOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 09:14:07 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33373 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593AbWLaOOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 09:14:06 -0500
Date: Sun, 31 Dec 2006 15:12:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mitch Bradley <wmb@firmworks.com>
cc: "OLPC Developer's List" <devel@laptop.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
In-Reply-To: <459714A6.4000406@firmworks.com>
Message-ID: <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
References: <459714A6.4000406@firmworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 30 2006 15:38, Mitch Bradley wrote:
>
> Request for comments.
>
> It is similar in some respect to fs/proc/proc_devtree.c , but does
> not use procfs, nor does it require an intermediate layer of code
> to create a flattened representation of the device tree.

NB: openpromfs does not use procfs either. It just happens to be
mounted somewhere down there.

> +++ b/Documentation/filesystems/ofwfs.txt
> +== Property Value Encoding ==
> +
> +A regular file in ofwfs contains the exact byte sequence that
> +comprises the OFW property value.  Properties are not reformatted
> +into text form, so numeric property values appear as binary
> +integers.  While this is inconvenient for viewing, it is generally
> +easier for programs that read property values, and it means that
> +Open Firmware documentation about property values applies
> +directly, without having to separately document an ASCII
> +transformation (which would have to separately specified for
> +different kinds of properties).

I appreciate the ASCII formatting that openpromfs currently does.
Perhaps, should OFWFS be used, it could offer both?

> +== Environment Assumptions ==
> +
> +The ofwfs code assumes that the Open Firmware client interface
> +callback can be executed during Linux kernel startup
> +(specifically, at "core_initcall" time).  When ofwfs is
> +initialized, it copies out the property values, so that subsequent
> +accesses to the tree do not require callbacks into OFW.

openpromfs also has many parts read-only, only one object,
/options/security-password, is writable. Hence caching it once and
forever seems ok.

BUT, the eeprom utility may be used to modify values, and if used, I
would like to see ofwfs show the updated value. openpromfs does it
today:

15:09 ares:/proc/openprom/options # cat oem-banner?
false
15:09 ares:/proc/openprom/options # eeprom 'oem-banner?=true'
15:09 ares:/proc/openprom/options # cat oem-banner?
true

(BTW, why does not openpromfs have it rw?)

> +== Recommended Mount Point ==
> +
> +The recommended mount point for ofwfs is /ofw.  (TBD: Should it be
> +mounted somewhere under /sys instead?)

Somewhere in /sys/firmware perhaps.


	-`J'
-- 

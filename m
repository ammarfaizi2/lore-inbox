Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKINfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKINfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKINfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:35:00 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:22713 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id S1750743AbVKINfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:35:00 -0500
From: Ian Soboroff <isoboroff@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic download of kernel rpms
References: <20051108062936.14482.qmail@web33308.mail.mud.yahoo.com>
	<200511080833.57710.gene.heskett@verizon.net>
	<1131459503.25192.42.camel@localhost.localdomain>
	<Pine.LNX.4.61.0511080910001.3265@chaos.analogic.com>
Date: Wed, 09 Nov 2005 08:34:55 -0500
In-Reply-To: <Pine.LNX.4.61.0511080910001.3265@chaos.analogic.com>
	(linux-os@analogic.com's message of "Tue, 8 Nov 2005 09:13:54 -0500")
Message-ID: <9cfd5lagd1c.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Tue, 8 Nov 2005, Alan Cox wrote:
>
>> On Maw, 2005-11-08 at 08:33 -0500, Gene Heskett wrote:
>>> Generally, no.  The exact reason is that rpms are a vendor item, and no
>>> fixed relation to the kernel.org tarballs.
>>
>> "make rpm" should build an RPM package from them but you will still need
>> to get the configuration correct before doing this.
>>
>
> Alan can verify that Red Hat Fedora puts the ".config" file in
> /boot as /boot/config-`uname -r`. This can be copied to the
> new kernel tree as ".config" and `make oldconfig` should get
> you a kernel configured very close to the one provided with
> the distribution.

Note that Fedora (and RHEL) kernels modularize nearly everything and
need an initrd to boot.  The kernel's "make rpm" does not make the
initrd for you (or fix up your grub.conf, IIRC).  So, the sequence is:

(unpack kernel)
cp /boot/config-`uname -r` .config
make oldconfig
(answer questions about new stuff)
make rpm
rpm -ivh <the-new-rpm>
mkinitrd /boot/initrd-<ver> <ver>
(edit grub.conf or what have you)

Ian


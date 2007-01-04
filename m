Return-Path: <linux-kernel-owner+w=401wt.eu-S964865AbXADOwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbXADOwp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbXADOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:52:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:56527 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964865AbXADOwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:52:44 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 09:52:44 EST
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: open(O_DIRECT) on a tmpfs?
To: Michael Tokarev <mjt@tls.msk.ru>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Thu, 04 Jan 2007 15:47:19 +0100
References: <7zzqw-SS-27@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H2TsG-0000h9-0Z@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> wrote:

> I wonder why open() with O_DIRECT (for example) bit set is
> disallowed on a tmpfs (again, for example) filesystem,
> returning EINVAL.
> 
> Yes, the question may seems strange a bit, because of two
> somewhat conflicting reasons.  First, there's no reason to
> use O_DIRECT with tmpfs in a first place, because tmpfs does
> not have backing store at all, so there's no place to do
> direct writes to.  But on another hand, again due to the very
> nature of tmpfs, there's no reason not to allow O_DIRECT
> open and just ignore it, -- exactly because there's no
> backing store for this filesystem.

I'm using a tmpfs as a mostly-ramdisk, that is I've set up a large swap
partition in case I need the RAM instead of using it for a filesystem.
Therefore it will sometimes have a backing store.

OTOH, ramfs does not have this property (the cache is the backing store),
so it would make sense to allow it at least there.

BTW: Maybe you could use a ramdisk instead of the loop-on-tmpfs.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html

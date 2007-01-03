Return-Path: <linux-kernel-owner+w=401wt.eu-S1752531AbXACAwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbXACAwP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXACAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:52:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:57406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbXACAwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:52:14 -0500
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 19:52:13 EST
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Shrink the held_lock struct by using bitfields.
To: Dave Jones <davej@redhat.com>, mingo@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 03 Jan 2007 01:47:36 +0100
References: <7z1oG-6Jr-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H1uI5-0000mn-0j@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:

> Shrink the held_lock struct by using bitfields.
> This shrinks task_struct on lockdep enabled kernels by 480 bytes.

>  * The following field is used to detect when we cross into an
>  * interrupt context:
>  */
> -     int                             irq_context;
[...]
> +     unsigned char irq_context:1;
[...]

Can these fields be set by concurrent processes, e.g.:
CPU0        CPU1
load flags
            load flags
            flip bit
            store
flip bit
store

?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html

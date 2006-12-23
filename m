Return-Path: <linux-kernel-owner+w=401wt.eu-S1753460AbWLWL6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbWLWL6G (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbWLWL6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:58:06 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2363 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbWLWL6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:58:05 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2006 06:58:04 EST
X-AuthUser: hirofumi@parknet.jp
To: Arjan van de Ven <arjan@infradead.org>
Cc: OGAWA Hirofumi <hogawa@miraclelinux.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] MMCONFIG: Fix x86_64 ioremap base_address
References: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
	<1166869244.3281.590.camel@laptopd505.fenrus.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 23 Dec 2006 20:49:49 +0900
In-Reply-To: <1166869244.3281.590.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Sat\, 23 Dec 2006 11\:20\:44 +0100")
Message-ID: <87fyb6n86a.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arjan van de Ven <arjan@infradead.org> writes:

> On Sat, 2006-12-23 at 10:02 +0900, OGAWA Hirofumi wrote:
>> Current -mm's mmconfig has some problems of remapped range.
>> 
>> a) In the case of broken MCFG tables on Asus etc., we need to remap
>> 256M range, but currently only remap 1M.
>
> I respectfully disagree. If the MCFG table is broken, we should not use
> it AT ALL. It's either a correct table, and we can use it, or it's so
> broken that we know it never has been tested etc etc, we're just better
> of to not trust it in that case.

Hm.. I see. Sounds sane to me. Well, my patch didn't add the new
workaround of broken table, it just fixes the oops of existence workaround.

Current workaround is the following (both of linus and -mm),

	if (pci_mmcfg_config_num == 1 &&
		cfg->pci_segment_group_number == 0 &&
		(cfg->start_bus_number | cfg->end_bus_number) == 0)
                /* Assume it can access 256M range */

But, if the system has bus number 0 only, it's a correct table.
We may need to detect the broken system. blacklist?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

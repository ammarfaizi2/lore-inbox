Return-Path: <linux-kernel-owner+w=401wt.eu-S964948AbXAJS3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbXAJS3b (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbXAJS3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:29:31 -0500
Received: from mail.parknet.jp ([210.171.160.80]:1100 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964948AbXAJS3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:29:30 -0500
X-AuthUser: hirofumi@parknet.jp
To: James.Smart@Emulex.Com
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fix the reproducible oops in scsi
References: <878xgbhpxg.fsf@duaron.myhome.or.jp> <45A4EACA.7020601@emulex.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 11 Jan 2007 03:29:20 +0900
In-Reply-To: <45A4EACA.7020601@emulex.com> (James Smart's message of "Wed\, 10 Jan 2007 08\:31\:54 -0500")
Message-ID: <87tzyyg2gv.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Smart <James.Smart@Emulex.Com> writes:

> I don't believe this is a valid fix. This is yet another case
> of the reuse-after-free issues on sdevs. The real issue is the
> deleted sdev isn't truly getting deleted due to references, and
> we're deadlocked trying to allocate a new one while the old one
> is outstanding. This fix just jumps over things. You're actually
> using a partially torn down sdev that, if the refcounts ever
> decremented, would be zapped - and you would be in a bunch of trouble.

I see. Can you explain more about reuse-after-free issue on sdevs? Is
there any test case or any info? Or is there any plan to fix it?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

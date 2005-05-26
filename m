Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVEZVaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVEZVaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEZV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:28:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:18134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261801AbVEZVZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:25:54 -0400
Date: Thu, 26 May 2005 14:24:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wolfgang Wander <wwc@rentec.com>
Cc: rlrevell@joe-job.com, petkov@uni-muenster.de, pharon@gmail.com,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc5-mm1 alsa oops
Message-Id: <20050526142444.01363443.akpm@osdl.org>
In-Reply-To: <42961700.5090005@rentec.com>
References: <1117092768.26173.4.camel@localhost>
	<200505261944.50942.petkov@uni-muenster.de>
	<1117130470.5477.5.camel@mindpipe>
	<200505262012.45833.petkov@uni-muenster.de>
	<1117132339.5477.20.camel@mindpipe>
	<42961700.5090005@rentec.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Wander <wwc@rentec.com> wrote:
>
> Lee Revell wrote:
> > On Thu, 2005-05-26 at 20:12 +0200, Borislav Petkov wrote:
> > 
> >>On Thursday 26 May 2005 20:01, Lee Revell wrote:
> >>
> >>>On Thu, 2005-05-26 at 19:44 +0200, Borislav Petkov wrote:
> >>>
> >>>><snip>
> >>>>
> >>>>Andrew,
> >>>>
> >>>>similar oopses as the one I'm replying to all over the place. At it
> >>>>happens m in snd_pcm_mmap_data_close(). Here's a stack trace:
> >>>
> >>>No one using ALSA CVS or any of the 1.0.9 release candidates ever
> >>>reported this, but lots of -mm users are... does that help at all?  I
> >>>suspect some upstream bug that ALSA just happens to trigger.
> >>
> >>yeah,
> >>
> >>this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses some 
> >>vm_area_struct->vm_private_data and apparently there have been some 
> >>optimizations to mmap code to avoid fragmentation of vma's so i think there's 
> >>the problem. However, we'll need the smarter ones here :))
> > 
> > 
> > Any idea which patches to back out?
> 
> 
> avoiding-mmap-fragmentation-fix-2.patch
> 
> seems to do the trick. Ken will likely have a fix-3 shortly ;-)
> 

Yup.  This appears to be not-an-alsa-bug.  Thanks.

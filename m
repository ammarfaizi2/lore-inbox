Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVE0QnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVE0QnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVE0QnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:43:21 -0400
Received: from fmr23.intel.com ([143.183.121.15]:7339 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262498AbVE0QnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:43:10 -0400
Message-Id: <200505271642.j4RGgbg03476@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Wolfgang Wander" <wwc@rentec.com>
Cc: <rlrevell@joe-job.com>, <petkov@uni-muenster.de>, <pharon@gmail.com>,
       <linux-kernel@vger.kernel.org>, <alsa-devel@lists.sourceforge.net>
Subject: RE: 2.6.12-rc5-mm1 alsa oops
Date: Fri, 27 May 2005 09:42:38 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcViO8649koqJsbTR5KcTlOUB0/7TwAaY/6g
In-Reply-To: <20050526142444.01363443.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Thursday, May 26, 2005 2:25 PM
> > >>
> > >>this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses some 
> > >>vm_area_struct->vm_private_data and apparently there have been some 
> > >>optimizations to mmap code to avoid fragmentation of vma's so i think there's 
> > >>the problem. However, we'll need the smarter ones here :))
> > > 
> > > 
> > > Any idea which patches to back out?
> > 
> > 
> > avoiding-mmap-fragmentation-fix-2.patch
> > 
> > seems to do the trick. Ken will likely have a fix-3 shortly ;-)
> > 
> 
> Yup.  This appears to be not-an-alsa-bug.  Thanks.


I'm the guilty one here.  avoiding-mmap-fragmentation-fix-2.patch has
a major clash using vm_private_data where alsa is also using.  I just
posted a patch, please try that out.  Thanks.

http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2

- Ken


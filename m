Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSHFSfg>; Tue, 6 Aug 2002 14:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHFSff>; Tue, 6 Aug 2002 14:35:35 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:12037 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S315259AbSHFSff>; Tue, 6 Aug 2002 14:35:35 -0400
Date: Tue, 6 Aug 2002 20:38:48 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add missing symbol exports
In-Reply-To: <Pine.LNX.4.44.0208061403580.7534-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0208062010370.32276-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Marcelo Tosatti wrote:

> On Tue, 6 Aug 2002, Pawel Kot wrote:
>
> > Hi,
> >
> > During the work on the NTFS backport I found that some sympols are missing
> > in ksyms exports. The following patch add the missing symbols. This is
> > against 2.4.19, as I can't find 2.4.20pre1 patch anywhere.
>
> Missing as in "used by the NTFS backport" ?

kmap_pte and kmap_prot are needed for all drivers that call
kmap_atomic() with HIGHMEM enabled. This is (indirectly) used also in
skbuff, but not sure whether the export is required there. And this is
also used in some peding patches AFAIK.

(local_)flush_tlb_page is already exported with the other archs, but not
ppc. As there's:
#define flush_tlb_page local_flush_page
maybe exporting just flush_tlb_page is enough. I can't remember if I
actually tried it, and have no PPC machine at the moment to do the test. I
don't think it is related to NTFS backport at all. I just met the problem
when trying to compile the kernel with NTFS backport on PPC.

set_buffer_async_io is not used at the moment by NTFS backport but IS used
by reiserfs.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku


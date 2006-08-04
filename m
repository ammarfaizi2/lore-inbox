Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWHDPP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWHDPP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHDPP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:15:56 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:59099 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S932330AbWHDPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:15:55 -0400
Message-ID: <44D364F9.3080703@kolumbus.fi>
Date: Fri, 04 Aug 2006 18:17:13 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, discuss@x86-64.org,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [Lhms-devel] [PATCH 4/10] hot-add-mem x86_64: Enable SPARSEMEM
 in	srat.c
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain> <20060804131409.21401.58904.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131409.21401.58904.sendpatchset@localhost.localdomain>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 04.08.2006 18:15:48,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 04.08.2006 18:15:48,
	Serialize complete at 04.08.2006 18:15:48,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 04.08.2006 18:15:48,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 04.08.2006 18:15:52,
	Serialize complete at 04.08.2006 18:15:52
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Mannthey wrote:
> From: Keith Mannthey <kmannth@us.ibm.com>
>
>  Enable x86_64 srat.c to share code between both reserve and sparsemem based add memory
> paths.  Both paths need the hot-add area node locality infomration (nodes_add).  This 
> code refactors the code path to allow this. 
>
> Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
>   
Ok nice, but.... hotadd_enough_memory() is broken, it does weird things 
with nd->start and nd->end which haven't been assigned even values yet. 
Also, mysterious business with find_e820_area and last_area_end...These 
areas are not in e820...

And why the reserve_bootmem_node()? Areas not RAM (per e820) are 
reserved anyways.

--Mika


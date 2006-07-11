Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWGKGPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWGKGPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWGKGPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:15:19 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:64645 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S965048AbWGKGPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:15:18 -0400
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump
	(2.6.18-rc1-i386) - safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       James.Bottomley@steeleye.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <9807.1152593732@kao2.melbourne.sgi.com>
References: <9807.1152593732@kao2.melbourne.sgi.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 11 Jul 2006 15:15:14 +0900
Message-Id: <1152598514.2414.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith!

On Tue, 2006-07-11 at 14:55 +1000, Keith Owens wrote:
> Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao (on Tue, 11 Jul 2006 13:21:01 +0900) wrote:
> >That is a good idea, but I have on concern. In mach-default by default
> >we use __send_IPI_shortcut (no_broadcast==0) instead of send_IPI_mask.
> >Is it always safe to ignore the no_broadcast setting? In other words,
> >can __send_IPI_shortcut be replaced by send_IPI_mask safely?
> 
> It is always safe to use send_IPI_mask.  It is not used by default
> because of concerns that send_IPI_mask may be slower than using a
> broadcast, although I do not know if anybody has measurements to back
> up that concern.  OTOH I can guarantee that sending NMI as a broadcast
> has problems, it breaks some Dell Xeon servers[1].  My fix was to never
> broadcast NMI, from 2.6.18-rc1 NMI_VECTOR always uses a mask[2] and
> crash was changed accordingly[3].
> 
> [1] http://marc.theaimsgroup.com/?t=114828920800003&r=1&w=2
> [2] http://marc.theaimsgroup.com/?t=115103727400006&r=1&w=2
> [3] http://marc.theaimsgroup.com/?t=115096703800003&r=1&w=2

Thank you for the links (I had forgotten about that thread) and
comments!
I prepared new patches and hopefully I got it right this time, Do they
look good this time (PATCH 4/4 in particular)?

Thank you in advance,

Fernando


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWGKE4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWGKE4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWGKE4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:56:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30094 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965211AbWGKE4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:56:19 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       James.Bottomley@steeleye.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id 
In-reply-to: Your message of "Tue, 11 Jul 2006 13:21:01 +0900."
             <1152591661.2414.11.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jul 2006 14:55:32 +1000
Message-ID: <9807.1152593732@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao (on Tue, 11 Jul 2006 13:21:01 +0900) wrote:
>That is a good idea, but I have on concern. In mach-default by default
>we use __send_IPI_shortcut (no_broadcast==0) instead of send_IPI_mask.
>Is it always safe to ignore the no_broadcast setting? In other words,
>can __send_IPI_shortcut be replaced by send_IPI_mask safely?

It is always safe to use send_IPI_mask.  It is not used by default
because of concerns that send_IPI_mask may be slower than using a
broadcast, although I do not know if anybody has measurements to back
up that concern.  OTOH I can guarantee that sending NMI as a broadcast
has problems, it breaks some Dell Xeon servers[1].  My fix was to never
broadcast NMI, from 2.6.18-rc1 NMI_VECTOR always uses a mask[2] and
crash was changed accordingly[3].

[1] http://marc.theaimsgroup.com/?t=114828920800003&r=1&w=2
[2] http://marc.theaimsgroup.com/?t=115103727400006&r=1&w=2
[3] http://marc.theaimsgroup.com/?t=115096703800003&r=1&w=2


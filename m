Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUHJNdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUHJNdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHJNcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:32:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266345AbUHJNaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:30:10 -0400
Date: Tue, 10 Aug 2004 09:29:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040810085746.GB12445@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0408100922490.7461-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Kurt Garloff wrote:

> Hi,
> 
> while looking into LSM hooks and SElinux for SLES9, we came across
> a couple of issues and the whole thing ended up in a patch that I
> think should be applied upstream.
> 
> Some boundary conditions:
> * We don't want to use selinux by default: The complexity to set up a
>   secure system using it is currently quite complex
> * The impact of SElinux on performance on SMP is disastrous

This is a known issue and is being worked on.

> * SElinux needs to be compiled in
> * CONFIG_SECURITY should remain on -- it allows the flexibility to
>   use different LSMs
> * This however has the nasty side-effect of ending up with a system
>   that uses dummy rather than the Linux default capabilities; so your
>   boot up scripts need to take care of loading it. Making capability
>   static is no option either, of course, as you want to be able to
>   use a different primary LSM or load capability as secondary LSM.
> * Even with selinux=0 and capability loaded, the kernel takes a 
>   few percents in networking benchmarks (measured by HP on ia64); 
>   this is caused by the slowliness of indirect jumps on ia64.
> 
> The first patch patch does just change the selinux default; so you
> need to enable with selinux=1.

This issue has been through a couple of iterations and the current scheme
where if you have SELinux enabled, it is on by default, is aimed at being
more secure by default.  On some platforms, boot parameters are not
feasible.  To allow SELinux to be disable for these, the /selinux/disable
node was implemented, which allows SELinux to be unregistered during boot.  
I suggest you investigate using this; look at what Fedora does.


- James
-- 
James Morris
<jmorris@redhat.com>



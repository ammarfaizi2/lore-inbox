Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423438AbWJZGLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423438AbWJZGLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 02:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423447AbWJZGLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 02:11:44 -0400
Received: from ms-smtp-03.ohiordc.rr.com ([65.24.5.137]:62716 "EHLO
	ms-smtp-03.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S1423438AbWJZGLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 02:11:44 -0400
Date: Thu, 26 Oct 2006 02:11:32 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061026061131.GA9265@nineveh.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org
References: <20061020015641.b4ed72e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: jhf@columbus.rr.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:56:41AM -0700, Andrew Morton wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
>

    The "Lazy interrupt disabling for 64-bit machines" patch
(which is in -rc2-mm2 through git-powerpc) seems to make -rc2-mm2
not build for ppc32 when KEXEC is enabled.  Building with kexec
enabled worked in -rc2-mm1.

    Building -mm2 fails when trying to make the vmlinux.  I don't have
the exact messages anymore, sorry, but it was an "undefined reference
to hard_irq_disable' in arch/powerpc/kernel/entry_32.S".  This appears
to be the result of an earlier warning about an "implicit
declaration of hard_irq_disable" in arch/powerpc/kernel/crash.c .

    (There's a comment at the top of that file that made it sound to
me like the file is for PPC64 only, but looking closer makes me think
that's not the case.)

    Backing out that "lazy interrupt" patch got -mm2 building again.
Turning kexec off works too.

    I don't use kexec, I just have it config'd on.  I doubt anyone is
actually using kexec in -mm on ppc32.  I'm just sayin'.

--
Joseph Fannin
jhf@columbus.rr.com


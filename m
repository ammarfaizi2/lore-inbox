Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263852AbTCVRu1>; Sat, 22 Mar 2003 12:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263853AbTCVRu1>; Sat, 22 Mar 2003 12:50:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33033 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263852AbTCVRu0>; Sat, 22 Mar 2003 12:50:26 -0500
Date: Sat, 22 Mar 2003 18:01:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030322180127.J8712@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjanv@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030322103121.A16994@flint.arm.linux.org.uk> <1048345130.8912.9.camel@irongate.swansea.linux.org.uk> <20030322141006.A8159@flint.arm.linux.org.uk> <1048346885.1708.2.camel@laptop.fenrus.com> <20030322171312.H8712@flint.arm.linux.org.uk> <1048360147.9221.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048360147.9221.26.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 22, 2003 at 07:09:08PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 07:09:08PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 17:13, Russell King wrote:
> > ptrace has always explicitly allowed a process with the CAP_SYS_PTRACE
> > capability to ptrace a task which isn't dumpable.  With the ptrace "fix"
> > in place, you can attach to a non-dumpable thread:
> 
> Note that this is a bug, and is now a fixed bug. The looser check you
> can do requires you check
> 
> 	my_capabilities >= his capbilities
> 
> Otherwise you have priviledge escalation for CAP_SYS_PTRACE to
> CAP_SYS_RAWIO trivially

In which case we should not allow ptrace to even attach to the process.
Currently you can attach to such a process and stop it running, even if
you have lesser priviledges than the child.

Therefore, I wouldn't call this "fixed" in the existing ptrace patch.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSCUR5w>; Thu, 21 Mar 2002 12:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312400AbSCUR5n>; Thu, 21 Mar 2002 12:57:43 -0500
Received: from scfdns02.sc.intel.com ([143.183.152.26]:40959 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S312404AbSCUR5a>; Thu, 21 Mar 2002 12:57:30 -0500
Message-Id: <200203211756.g2LHuvW11535@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Date: Thu, 21 Mar 2002 09:59:49 -0500
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dan@debian.org (Daniel Jacobowitz),
        vamsi@in.ibm.com (Vamsi Krishna S .), pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        tachino@jp.fujitsu.com, jefreyr@pacbell.net, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <E16o6SJ-0005mD-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2002 12:34 pm, Alan Cox wrote:
> > This why I grabbed all those locks, and did the two sets of IPI's in the
> > tcore patch.  Once the runqueue lock is grabbed, even if that process on
> > the
>
> If you IPI holding a lock whats going to happen if while the IPI is going
> across the cpus the other processor tries to grab the runqueue lock and
> is spinning on it with interrupts off ?

Then the at least 2 CPU's would quickly become dead locked on the 
synchronization IPI this patch sends at the end of the suspend_other_threads 
function call.

Interrupts shouldn't be turned off when grabbing the runqueue lock.  Its also 
a bad thing if they would happen to be off while calling into to schedule.  

I think schedule was designed to be called only while interrupts are turned 
on.  It BUG's if "in_interrupt" to enforce this.

--mgross


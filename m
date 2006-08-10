Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWHJMAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWHJMAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWHJMAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:00:14 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:61848 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1161187AbWHJMAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:00:13 -0400
Subject: Re: [PATCH 1/2] i386: Disallow kprobes on NMI handlers - try #2
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: prasanna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
In-Reply-To: <200608101352.08828.ak@suse.de>
References: <1155209773.4141.10.camel@localhost.localdomain>
	 <200608101352.08828.ak@suse.de>
Content-Type: text/plain; charset=utf-8
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Thu, 10 Aug 2006 21:00:10 +0900
Message-Id: <1155211210.4141.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 13:52 +0200, Andi Kleen wrote:
> On Thursday 10 August 2006 13:36, Fernando Luis Vázquez Cao wrote:
> > A kprobe executes IRET early and that could cause NMI recursion and stack
> > corruption.
> > 
> > Note: This problem was originally spotted and solved by Andi Kleen in the
> > x86_64 architecture. This patch is an adaption of his patch for i386.
> 
> Originally Jan Beulich discovered these classes of bugs actually
Sorry for the mistake Jan.

> I applied the two patches (after fixing lots of rejects because that
> code had already changed a lot). But I have my doubts it is complete.
> 
> e.g. the NMI watchdog nmi code has lots of callees which you don't
> handle (notifier chains, spinlocks, printks which can call practically everything, ...) 
> 
> The printk in the NMI handler look pretty bogus so I just removed it.
I had done the same in my local repository (^-^).

> But all the other code would be tricky. but .e.g. marking up 
> spinlocks would be probably not a good idea. 
> 
> When we oops (call die) perhaps we can force kprobes to be disabled? 
> 
> Also everybody hooking into the die chain would need to be covered too.
> 
> Probably some followon work is needed.
Agreed. In fact I am currently working on that. I sent the previous
patches just to get started.

Thank you,

Fernando


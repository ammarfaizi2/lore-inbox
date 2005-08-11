Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVHKSLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVHKSLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVHKSLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:11:11 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65449 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932340AbVHKSLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:11:10 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508111342170.15330@chaos.analogic.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
	 <1123781187.17269.77.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508111342170.15330@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 14:11:02 -0400
Message-Id: <1123783862.17269.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 13:46 -0400, linux-os (Dick Johnson) wrote:

> 
> I was talking about the one who had the glibc support to use
> the newer system-call entry (who's name can confuse).
> 
> You are looking at code that uses int 0x80. It's an interrupt,
> therefore, in the kernel, once the stack is set up, interrupts
> need to be (re)enabled.

int is a call to either an interrupt or exception procedure. 0x80 is
setup in Linux to be a trap and not an interrupt vector. So it does
_not_ turn off interrupts.

I'm looking at the sysenter code which is suppose to be the fast entry
into the system, and it looks like it is suppose to call the
sysenter_entry when used.  I'm trying to write something to test this
out, since I still have the ud2 op in my sysentry code. So if I do get
this to work, I can cause a bug.

-- Steve



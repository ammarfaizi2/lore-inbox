Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbULLQ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbULLQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbULLQ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 11:26:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:54673 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261831AbULLQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 11:26:57 -0500
Date: Sun, 12 Dec 2004 09:26:29 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
cc: George Anzinger <george@mvista.com>, Lee Revell <rlrevell@joe-job.com>,
       dipankar@in.ibm.com, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
In-Reply-To: <41BC0854.4010503@colorfullife.com>
Message-ID: <Pine.LNX.4.61.0412120656260.14734@montezuma.fsmlabs.com>
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com>
 <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com>
 <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com>
 <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com>
 <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com>
 <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
 <41BC0854.4010503@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004, Manfred Spraul wrote:

> Zwane Mwaikambo wrote:
> 
> > "Intel processors don't suppress SMI or NMI after an STI instruction. Since
> > the INTR suppresion is not preserved across an SMI or NMI handler, this may
> > result in an INTR being serviced after the STI, which constitutes a
> > violation of the INTR suppresion.
> >  
> Interesting find.
> It means that our NMI irq return path should check if it points to a hlt
> instruction and if yes, then increase the saved EIP by one before doing the
> iretd, right?

Yeah that should do it, but then we also have to worry about SMIs, perhaps 
we could add similar logic to interrupt return path instead?

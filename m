Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbULLI7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbULLI7i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 03:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbULLI7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 03:59:38 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:62151 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262055AbULLI7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 03:59:36 -0500
Message-ID: <41BC0854.4010503@colorfullife.com>
Date: Sun, 12 Dec 2004 09:59:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: George Anzinger <george@mvista.com>, Lee Revell <rlrevell@joe-job.com>,
       dipankar@in.ibm.com, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com> <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com> <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com> <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>"Intel processors don't suppress SMI or NMI after an STI instruction. 
>Since the INTR suppresion is not preserved across an SMI or NMI handler, 
>this may result in an INTR being serviced after the STI, which constitutes 
>a violation of the INTR suppresion.
>  
>
Interesting find.
It means that our NMI irq return path should check if it points to a hlt 
instruction and if yes, then increase the saved EIP by one before doing 
the iretd, right?

--
    Manfred

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUF3Sw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUF3Sw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUF3Sw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:52:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:44268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263824AbUF3Sv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:51:59 -0400
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linas@austin.ibm.com
Cc: paulus@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040630123637.S21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com>
	 <1088559864.1906.9.camel@gaston>
	 <20040630123637.S21634@forte.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1088621248.1920.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 13:47:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, the problem was that there is no lock that is protecting the
> use of the single, global buffer.  Adding yet another lock is bad;
> it makes hunting for deadlocks that much more tedious and difficult;
> already, finding deadlocks is error-prone, and subject to bit-rot as
> future hackers update the code.  So instead, the problem can be easily
> avoided by not using a global buffer.  The code below mallocs/frees.
> Its not perf-critcal, so I don't mind malloc overhead.  Would this
> work for you?  Patch attached below.

I prefer that, but couldn't we move the kmalloc outside of the spinlock
and so use GFP_KERNEL instead ?

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUF3TGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUF3TGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUF3TGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:06:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:57836 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261159AbUF3TGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:06:01 -0400
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: linas@austin.ibm.com, paulus@au1.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40E30E50.3040401@austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com>
	 <1088559864.1906.9.camel@gaston>
	 <20040630123637.S21634@forte.austin.ibm.com>
	 <1088621248.1920.43.camel@gaston>  <40E30E50.3040401@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1088622136.1921.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 14:02:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Isn't the global buffer used since it's in BSS, and as such, in low 
> memory, guaranteed to be below 4GB? RTAS has limitations that restricts 
> any passed-in buffers to be addressable as 32-bit real mode pointers, right?

The global buffer is still used within the spinlocked region for RTAS itself,
the patch just uses a local buffer and copies into it from the global one
before releasing the lock.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUKSAlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUKSAlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbUKSAkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:40:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:55273 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262916AbUKSAbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:31:10 -0500
Subject: Potential security problem in patch: Fix reading /proc/<pid>/mem
	when parent dies.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <200411181704.iAIH4SSb023079@hera.kernel.org>
References: <200411181704.iAIH4SSb023079@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100820455.6019.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 23:27:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 16:01, Linux Kernel Mailing List wrote:
> ChangeSet 1.2155, 2004/11/18 08:01:00-08:00, torvalds@ppc970.osdl.org
> 
> 	Fix reading /proc/<pid>/mem when parent dies.
> 	
> 	We should not touch "self_exec_id" here. The parent changed,
> 	not we.

The original point of this was that if our parent changed then our new
parent is not aware of our special status. As a result we can send
random signals to init and since it does not see SIGCLD we can get
zombies or worse when we exit.

The original code was correct here for protecting init. The side effect
does need fixing but not this way. Perhaps it would be simpler just to
protect init as it is already "special" for signal handling.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWKEFlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWKEFlg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 00:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWKEFlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 00:41:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:23684 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161008AbWKEFlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 00:41:35 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
Date: Sun, 5 Nov 2006 06:41:14 +0100
User-Agent: KMail/1.9.5
Cc: Benjamin LaHaise <bcrl@kvack.org>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <20061105035556.GQ9057@kvack.org> <Pine.LNX.4.64.0611041959260.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611041959260.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611050641.14724.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For me, when compiled with -O2, it results in
> 
> 	84
> 	88
> 	132
> 
> which basically says: a "rdtsc->rdtsc" is 84 cycles, putting a "pushfl" in 
> between is another _4_ cycles, and putting a "popfl" in between is about 
> another 48 cycles. 

This means we should definitely change restore_flags() to only STI, 
never popf

-Andi

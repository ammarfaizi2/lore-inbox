Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUHXGSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUHXGSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbUHXGSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:18:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:32472 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266532AbUHXGRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:17:31 -0400
Date: Tue, 24 Aug 2004 08:17:29 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix MTRR strings definition.
Message-Id: <20040824081729.311ee677.ak@suse.de>
In-Reply-To: <20040823232320.GA1875@redhat.com>
References: <20040823232320.GA1875@redhat.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 00:23:20 +0100
Dave Jones <davej@redhat.com> wrote:

> Instead of deleting the extern from include/asm/mtrr.h, I believe
> the correct fix would be to move the strings back to the include file
> where they belong.
> The reason behind this, is that there are userspace apps (admittedly
> few, but we even ship two in Documentation/mtrr.txt) that rely upon
> these definitions being in that header.  This has been broken for
> all 2.6 releases so far. Patch below fixes things back the way it
> was in 2.4

That's rather ugly. It would be cleaner to just have a 
macro that expands to the strings, and everybody who wants to use
it declares an own array using that macro.


> Andi, I don't have gcc 3.5 to hand, I trust this fixes whatever
> problem you saw there too ?

3.5 doesn't like it when something is declared both extern and static.
Your new patch has this problem again.

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUCXQjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUCXQjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:39:01 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:1676 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263770AbUCXQi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:38:59 -0500
Message-ID: <4061B764.5070008@BitWagon.com>
Date: Wed, 24 Mar 2004 08:29:24 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <20040323231256.GP4677@tpkurt.garloff.de>	<20040323154937.1f0dc500.akpm@osdl.org>	<20040324002149.GT4677@tpkurt.garloff.de>	<16480.55450.730214.175997@napali.hpl.hp.com>	<4060E24C.9000507@redhat.com>	<16480.59229.808025.231875@napali.hpl.hp.com>	<20040324070020.GI31589@devserv.devel.redhat.com>	<16481.13780.673796.20976@napali.hpl.hp.com>	<20040324072840.GK31589@devserv.devel.redhat.com> <16481.15493.591464.867776@napali.hpl.hp.com>
In-Reply-To: <16481.15493.591464.867776@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub> but it is still possible some language interpreter or
Jakub> something builds code on the fly on the stack).

David> That's why there is mprotect().

But mprotect() costs enough (hundreds of cycles) to be a significant burden
in some cases.  Generating code to a stack region that is inherently
executable is inexpensive (even allowing for restrictive alignment and
avoiding I/D cache conflicts), is thread safe, is async-signal safe, and
takes less work than other alternatives.  Yes, the "black hats" do this;
so do the "white hats."  Please do not increase the minimum cost for
applications that want generate-and-execute on the stack at upredictable
high frequency.

-- 
John Reiser, jreiser@BitWagon.com


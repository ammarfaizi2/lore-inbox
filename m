Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVCDAj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVCDAj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVCDAgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:36:24 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:34820 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262563AbVCDAdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:33:16 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][16/26] IB/mthca: mem-free doorbell record writing
X-Message-Flag: Warning: May contain useful information
References: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>
	<4227A606.50703@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 16:33:15 -0800
In-Reply-To: <4227A606.50703@pobox.com> (Jeff Garzik's message of "Thu, 03
 Mar 2005 19:04:22 -0500")
Message-ID: <52vf88ntbo.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 00:33:15.0516 (UTC) FILETIME=[C12A93C0:01C52051]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> Are you concerned about ordering, or write-combining?

ordering... write combining would be fine.

    Jeff> I am unaware of a situation where writes are re-ordered into
    Jeff> a reversed, descending order for no apparent reason.

Hmm... I've seen ppc64 do some pretty freaky reordering but on the
other hand that's a 64-bit arch so we don't care in this case.  I
guess I'd rather keep the barrier there so we don't have the
possibility of a rare hardware crash when the HCA just happens to read
the doorbell record in a corrupt state.

 - R.

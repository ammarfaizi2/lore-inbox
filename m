Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUDTQ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUDTQ2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUDTQ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:26:34 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:50576 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263555AbUDTQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:26:21 -0400
To: Eli Cohen <mlxk@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysrq shows impossible call stack
References: <408545AA.6030807@mellanox.co.il>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 20 Apr 2004 09:26:17 -0700
In-Reply-To: <408545AA.6030807@mellanox.co.il>
Message-ID: <52ekqizkd2.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Apr 2004 16:26:17.0886 (UTC) FILETIME=[35274BE0:01C426F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Eli> Hi, I am exsperiencing a hang, probably caused by a deadlock,
    Eli> so I can do sysrq commands. However I can see that in some
    Eli> cases the exspected call stack has some functions in between
    Eli> as if two call stack are interleaved.

Hi Eli,

I think what you are seeing is old values left on the stack.  If a
function allocates space for local variables but bumping the stack
pointer, but then never actually uses those variables, then old values
including old return addresses may be left in the stack.

 - Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTJITe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbTJITe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:34:29 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46864 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262412AbTJITe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:34:27 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
Date: 9 Oct 2003 19:24:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm4clt$5n6$1@gatekeeper.tmr.com>
References: <20031005013326.3c103538.akpm@osdl.org> <1065655095.1842.34.camel@ibm-c.pdx.osdl.net> <20031009111624.GA11549@in.ibm.com>
X-Trace: gatekeeper.tmr.com 1065727485 5862 192.168.12.62 (9 Oct 2003 19:24:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031009111624.GA11549@in.ibm.com>,
Suparna Bhattacharya  <suparna@in.ibm.com> wrote:
| On Wed, Oct 08, 2003 at 04:18:15PM -0700, Daniel McNeil wrote:
| 
| __aio_run_iocbs should have been called only for buffered i/o, 
| so this sounds like an O_DIRECT fallback to buffered i/o.
| Possibly after already submitting some blocks direct to BIO,
| the i/o completion path for which ends up calling aio_complete
| releasing the iocb. That could explain the use-after-free situation
| you see.
| 
| But, O_DIRECT write should fallback to buffered i/o only if it 
| encounters holes in the middle of the file, not for simple appends 
| as in your case. Need to figure out how this could have happened ...

Are the write kept ordered?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

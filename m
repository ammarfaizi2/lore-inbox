Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVKOEue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVKOEue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKOEue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:50:34 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:15292 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932384AbVKOEud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:50:33 -0500
Date: Mon, 14 Nov 2005 23:15:01 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115051501.GA3252@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114193715.1dd80786.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> Serge wrote:
> > the vserver model
> 
> What's that?

:)  Well a vserver pretends to be a full system of its own, though you
can have lots of vservers on one machine.  Processes in each virtual
server see only other processes in the same vserver.  However in
vserver the pids they see are the real kernel pids - except for one
process per vserver which can be the fakeinit.  Other processes in the
same vserver see it as pid 1, but to the kernel it is still known by
its real pid.

> How large is our numeric pid space (on 64 bit systems, anyway)?  If
> large enough, then reservation of pid ranges becomes an easy task.  If
> say we had 10 bits to spare, then a server farm could pre-ordain say a
> thousand virtual servers, which come and go on various hardware
> systems, each virtual server with its own hostname, pid-range, and
> other such paraphernalia.

In fact this is one way we considered implementing the virtual pids -
the pidspace id would be the upper some bits of the pid, and the vpid
would be the lower bits, so that the kernel pid would simply be
(pidspace_id << some_shift | vpid).

-serge


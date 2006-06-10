Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWFJJxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWFJJxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 05:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWFJJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 05:53:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32488 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751457AbWFJJxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 05:53:37 -0400
Date: Sat, 10 Jun 2006 10:53:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060610095333.GB20526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605144328.GA12904@sergelap.austin.ibm.com> <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com> <20060609232551.GA11240@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609232551.GA11240@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 06:25:51PM -0500, Serge E. Hallyn wrote:
> Quoting Eric W. Biederman (ebiederm@xmission.com):
> > If you want to help with the bare pid to struct pid conversion I
> > don't have any outstanding patches, and getting that done kills
> > some theoretical pid wrap around problems as well as laying the ground
> > work for a simple pidspace implementation.
> > 
> > Eric
> 
> Is this the sort of thing you are looking for?  Is this worthwhile for
> kernel_threads, or only for userspace threads - i.e. do we expect kernel
> threads to live?
> 
> If we do want to do this for kernel threads, then I assume that
> eventually we'll want to change kernel_thread() itself.  I actually
> started to do that earlier, but of course that way every user would
> have to be changed in the same patch :)


> 
> Subject: [PATCH] struct pid: convert ieee1394 to hold struct pid
> 
> ieee1394 driver caches pid_t's for kernel threads.  Switch to
> holding a reference to a struct pid.  This prevents concern
> about the cached pid pointing to the wrong process after the
> kernel thread dies and pids wrap around.

NACK.  please conver to the kthread_ API instead.  A reference to a pid_t
in a driver should generally be treated as a bug, the few exception should
be discussed on lkml and commented verbosely.


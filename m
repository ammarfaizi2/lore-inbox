Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVERPsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVERPsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVERPq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:46:28 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:2753 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262281AbVERPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:45:10 -0400
Subject: Re: Share Wait Queue between different modules ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050518150200.88195.qmail@web8506.mail.in.yahoo.com>
References: <20050518150200.88195.qmail@web8506.mail.in.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 18 May 2005 11:45:03 -0400
Message-Id: <1116431103.5014.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 16:02 +0100, Dinesh Ahuja wrote:
> Thanks Steven for answer.
> 
> Could please tell me know how to share wait queue
> between different modules and where will be pratical
> implementation of that case.

A wait_queue is where a task goes while waiting for some event. If you
want to share it among modules you first need to determine where the
wait queue would be declared.  If module A and module B use the same
wait queue, and module A has declared it. Then module B would be
dependent on module A.  Module A would also have to export the wait
queue via the EXPORT_SYMBOL macro.  Or, the wait queue can be declared
in the kernel itself and all modules can use it. 

As for a practical implementation for doing this, I'm not sure what you
are asking for since the question itself is quite abstract.  I haven't
needed to export a wait queue from one module to the next. The best I
can tell you is if one module supplies some functionality or driver for
some device that has a wait queue for some event, and another module
adds functionality or a sub system of the device that needs to have
tasks wait on the same event, then I guess that would be one case.

-- Steve



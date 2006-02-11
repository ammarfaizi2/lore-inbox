Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWBKBUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWBKBUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWBKBUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:20:23 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:27836 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932294AbWBKBUW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:20:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=abaj8S7HWaOuNg//j5qvd1WKNOyS7xF8n2ulJ2cyk8bh2F+z4EytLTV8YQ0sOfUDGv1Uast6WxXuYyipt8ZOHfclKwDLq4inz94nD9HsRm2HLDbna2wZPIvwhcxUHQhN4Dy+/27iJ/lsx+EZAg71+ymVsA2IDNnl7JX4dmddZB4=
Message-ID: <787b0d920602101720q5f70129fl327d00701d66a215@mail.gmail.com>
Date: Fri, 10 Feb 2006 20:20:21 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: do_notify_resume()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the function included below, which appears at the
very end of arch/i386/kernel/signal.c, why is TIF_IRET
being cleared? Is it for the next entry into the kernel
(not the present one)? This could use a comment.

/*
 * notification of userspace execution resumption
 * - triggered by the TIF_WORK_MASK flags
 */
__attribute__((regparm(3)))
void do_notify_resume(struct pt_regs *regs, void *_unused,
                      __u32 thread_info_flags)
{
        /* Pending single-step? */
        if (thread_info_flags & _TIF_SINGLESTEP) {
                regs->eflags |= TF_MASK;
                clear_thread_flag(TIF_SINGLESTEP);
        }

        /* deal with pending signal delivery */
        if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
                do_signal(regs);

        clear_thread_flag(TIF_IRET);
}

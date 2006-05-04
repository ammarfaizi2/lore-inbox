Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWEDFze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWEDFze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 01:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWEDFze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 01:55:34 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:33469 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751369AbWEDFze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 01:55:34 -0400
Date: Wed, 3 May 2006 22:55:32 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: limits / PIPE_BUF?
Message-ID: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was reading through the include/linux/limits.h file in order to
generate a cleanup patch for it -- a large number of #defines within
that file are no longer being used, as I surmise that they are simply
remnants of earlier implementations.

A snippet from include/linux/limits.h:
#define PIPE_BUF        4096    /* # bytes in atomic write to a pipe */

PIPE_BUF is a bit of an oddity. It is defined there, then redefined in
the arm header files, even though those header files are never included
anywhere. Also, PIPE_BUF is never referenced by name in any of the Linux
code. And yet, it is still being mentioned in some Big And Scary
Warnings (tm): fs/autofs4/waitq.c or include/linux/pipe_fs_i.h, for
example.

What's the deal with PIPE_BUF? Is its value used in the code indirectly,
so that more comments would help make this fact obvious? Or is it now
deprecated, and therefore a viable target for include/linux/limits.h
cleanups?

- Vadim Lobanov

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVJKI4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVJKI4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVJKI4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:56:45 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:21517 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751427AbVJKI4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:56:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ej86N+6CfITo6q+ImQHuZDdKdw+TaAAnXRdZ7djZGisb40O4hCLNN1z+TRvKiAILKnuxeuZooZD16tCqHmwgvqS0gNZbVg9Swa5zMmCMvkUbQO7fafQOb7GPWDNdgDOsMj/mVjP3L+fkkWfqhkGKveHx1UctPdKVf5zCoeXdaTk=
Message-ID: <121a28810510110156q1369b9dg@mail.gmail.com>
Date: Tue, 11 Oct 2005 10:56:43 +0200
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sys_sendfile oops in 2.6.13?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I found an (IMHO) silly bug in do_sendfile in 2.6.13.x kernels (at
least in 2.6.13.3 and .4, didn't backtrack to find where it
originated). Without the patch all I apparently get from sys_sendfile
is an oops due to a call in sys_sendfile with ppos being NULL. With the
patch it works OK. Noticed in vsftpd.

The patch may apply with some fuzz as my kernel is somehwat patched but
the gist of the patch is the same anyway

Regards,
 Grzegorz Nosek

--- linux-2.6/fs/read_write.c~  2005-10-06 21:35:03.000000000 +0200
+++ linux-2.6/fs/read_write.c   2005-10-05 19:14:04.000000000 +0200
@@ -719,7 +719,7 @@
       current->syscr++;
       current->syscw++;

-       if (*ppos > max)
+       if (ppos && *ppos > max)
               retval = -EOVERFLOW;

 fput_out:

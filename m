Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTEYLcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTEYLcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:32:24 -0400
Received: from mcmmta2.mediacapital.pt ([193.126.240.147]:21960 "EHLO
	mcmmta2.mediacapital.pt") by vger.kernel.org with ESMTP
	id S261932AbTEYLcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:32:23 -0400
Date: Sun, 25 May 2003 12:46:25 +0100
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
Subject: Question on verify_area() and friends wrt
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Message-id: <20030525124625.4dedc758.l16083@alunos.uevora.pt>
Organization: Universidade de Evora
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been taking care of auditing some return values for instances of
unchecked copy_*_user calls and I've come across one case that's
marked as a bug at kbugs.org which however doesn't seem like one to me.
The piece of code I'm referring can be found in
net/bluetooth/hci_core.c:436

if (!verify_area(VERIFY_WRITE, ptr, sizeof(ir) +
		(sizeof(struct inquiry_info) * ir.num_rsp))) {
    copy_to_user(ptr, &ir, sizeof(ir));
    ptr += sizeof(ir);
    copy_to_user(ptr, buf, sizeof(struct inquiry_info) * ir.num_rsp);	} else
    err = -EFAULT;

I'm presuming verify_area() does its job fine returning 0 if the memory
is valid and -EFAULT if not. Thus, given the exact check that's been
done, there seems indeed to exist no need to check each call to
copy_to_user() below. Or is there?

Thanks in advance,


		Paulo

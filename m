Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUECKuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUECKuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 06:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUECKuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 06:50:44 -0400
Received: from firewall.conet.cz ([213.175.54.250]:58058 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S263629AbUECKun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 06:50:43 -0400
Date: Mon, 3 May 2004 12:50:41 +0200
From: Libor Vanek <libor@conet.cz>
To: linux-kernel@vger.kernel.org
Subject: Reading from file in module fails
Message-ID: <20040503105041.GA12023@Loki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm writing module which needs to read from file. I've got this simple sample code:

char buffer[4096];
ssize_t read;
file *f;
f = filp_open("/some/file",O_RDONLY | O_LARGEFILE,0);
f->f_pos = 0;
read = vfs_read(f,(char __user *) buffer,4096,&f->f_pos);

but here read value is "-14" (-EINVAL?) Does anybody has idea what's wrong? 

It seems that file is opened OK (I've tested:
if (f->f_op->read) {
	read = f->f_op->read(file, buf, count, pos);
}
and result was the same - so I assume that file is opened OK and structure "file f" is filled correctly.


I need to copy files (yes - I know that kernel shouldn't do this but I REALLY need) and there is nothing like "sys_copy" and "sys_sendfile" is not exported (which seems strange to me but there is nothing like EXPORT_SYMBOL(sys_sendfile) in fs/read_write.c


Thanks,
Libor Vanek


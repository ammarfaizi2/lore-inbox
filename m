Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUECAAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUECAAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUECAAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 20:00:15 -0400
Received: from firewall.conet.cz ([213.175.54.250]:5548 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S263370AbUECAAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 20:00:11 -0400
Date: Mon, 3 May 2004 02:00:04 +0200
From: Libor Vanek <libor@conet.cz>
To: linux-kernel@vger.kernel.org
Subject: Read from file fails
Message-ID: <20040503000004.GA26707@Loki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
can anybody help me with reading from file? I've got this code in my module for 2.6.5-mm6:

char buffer[4096];
ssize_t read;
file *f;
f = filp_open("/some/file",O_RDONLY | O_LARGEFILE,0);
f->f_pos = 0;
read = vfs_read(f,(char __user *) buffer,4096,&f->f_pos);


but here read value is "-14" :-((( any hints?

It seems that file is opened OK (I've tested: 
if (f->f_op->read) {
	read = f->f_op->read(file, buf, count, pos);
}
and result was the same - so I assume that file is opened OK and structure "file f" is filled correctly.

I need to copy files (yes - I know that kernel shouldn't do this but I REALLY need) and  there is nothing like "sys_copy" and "sys_sendfile" is not exported (which seems strange to me but there is nothing like EXPORT_SYMBOL(sys_sendfile) in fs/read_write.c


Thanks,
Libor Vanek


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTDGIt7 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTDGIt6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:49:58 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:60366 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263350AbTDGItx (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:49:53 -0400
Message-ID: <20030407090123.11516.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2003 04:01:23 -0500
Subject: Re: [PATCH] new syscall: flink
X-Originating-Ip: 172.132.120.71
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do file access capabilities (and ACLs where those
are enabled)attach to the directory entry or the inode for a file? 

I remember Linus wishing that capabilities
on files could have different multiple concurrent values in different directory entry contexts.
Seems like the kernel would need to be able
to trump these "capability views", which
would need to be associated with directory
entries, based on data stored with the inode
(so that you can drop capabilities when creating
a link but you can't elevate them).

(Someone already mentioned in this thread that traditional unix permissions are stored in the inode.)

The restricted directories with loose permissions
on the files within them looks more like an
application programmer issue than a kernel issue to me. The parent or server could always chmod the file(or copy it to a read-only file and open that) before execing or passing the open fd.

So who owns the inode? Or does "owned by
uid #N" only make sense in the context of a
directory entry? If so, does ownership of the linked-to fd propagate to the new directory
entry from the old directory entry? What if it
had been unlinked before the flink()?

Seems like the ultimate security constraints on files have to be stored in the inode or your security is potentially hosed merely by the ability to create a new directory entry for the same inode from a different uid (whether it
needs to do it in a different directory is a
separate issue). 
 
Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup


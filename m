Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281527AbRKMGQ7>; Tue, 13 Nov 2001 01:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281535AbRKMGQt>; Tue, 13 Nov 2001 01:16:49 -0500
Received: from rj.sgi.com ([204.94.215.100]:59111 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281534AbRKMGQh>;
	Tue, 13 Nov 2001 01:16:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: neilb@cse.unsw.edu.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
In-Reply-To: Your message of "Mon, 12 Nov 2001 22:03:41 -0800."
             <20011112.220341.54186374.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 17:16:26 +1100
Message-ID: <12682.1005632186@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001 22:03:41 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Neil Brown <neilb@cse.unsw.edu.au>
>   Date: Tue, 13 Nov 2001 16:54:00 +1100 (EST)
>
>   uhci.c:2986: warning: initialization discards qualifiers from pointer target type
>
>The correct fix for this one is below and already sent
>to Linus:
>
>diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/linux/module.h linux/include/linux/module.h
>--- vanilla/linux/include/linux/module.h	Mon Nov 12 15:13:12 2001
>+++ linux/include/linux/module.h	Mon Nov 12 17:11:04 2001
>@@ -317,7 +317,7 @@
>  * const, other exit data may be writable.
>  */
> #define MODULE_GENERIC_TABLE(gtype,name) \
>-static struct gtype##_id * __module_##gtype##_table \
>+static const struct gtype##_id * __module_##gtype##_table \
>   __attribute__ ((unused, __section__(".data.exit"))) = name
> 
> #ifndef __GENKSYMS__

That breaks objects which have other __section__(".data.exit") info
which is not marked const.  I put a comment just above that change...


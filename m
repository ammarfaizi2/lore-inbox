Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268789AbTGJCWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 22:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbTGJCWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 22:22:42 -0400
Received: from almesberger.net ([63.105.73.239]:34568 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S268789AbTGJCWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 22:22:40 -0400
Date: Wed, 9 Jul 2003 23:37:07 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
Message-ID: <20030709233707.B6409@almesberger.net>
References: <20030709220825.A22087@almesberger.net> <20030709.180830.39180836.davem@redhat.com> <20030709230637.A6409@almesberger.net> <20030709.190656.23035889.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709.190656.23035889.davem@redhat.com>; from davem@redhat.com on Wed, Jul 09, 2003 at 07:06:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I was considering structure definitions, macros, and whatnot
> as well.

Yes, structure definitions and the like are fine. Sorry, I wasn't
quite clear: it's the code living in include/* for apparently no
good reason (i.e. it's only used at one place, is unlikely to be
used by modules, and doesn't define an interface) that I find
irritating.

BTW, even of the macros with arguments, about 66% seem to be of
the "local use only" type.

#!/bin/sh
SRC=include/net/tcp.h
for n in `sed '/^# *define[^!-~]*\([a-zA-Z_0-9]*\)(.*/s//\1/p;d' \
  <$SRC | sort | uniq`; do
    echo -n "$n: "
    echo `find . -name '*.[ch]' | fgrep -vx ./$SRC | xargs grep -lrw $n`
done

wc -l out2
     21 out2
sed 's|\./net/ipv4/[^/]*\>||g' <out2 | fgrep -v . | wc -l
     14

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268736AbTGJBwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbTGJBwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:52:10 -0400
Received: from almesberger.net ([63.105.73.239]:26888 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S268736AbTGJBwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:52:04 -0400
Date: Wed, 9 Jul 2003 23:06:37 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
Message-ID: <20030709230637.A6409@almesberger.net>
References: <20030707080929.A1848@infradead.org> <20030707.195350.39170946.davem@redhat.com> <20030709220825.A22087@almesberger.net> <20030709.180830.39180836.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709.180830.39180836.davem@redhat.com>; from davem@redhat.com on Wed, Jul 09, 2003 at 06:08:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Bad example, I'd say that %65 of that file is used in net/ipv6/*.c
> files too.

Considering only inline functions, 64 of the 89 functions my script
below finds in my 2.5.72 tree are only used in net/ipv4 (or tcp.h
itself). That's almost 72%. Only 22 of the functions (25%) are used
in net/ipv6.

A lot of the code there is basically an extension of net/ipv4/tcp*.c,
so it seems odd to put it at a completely different location, only
because it happens to be inlined.

#!/bin/sh
SRC=include/net/tcp.h
for n in `sed '/^.*inline.* \([a-zA-Z_0-9]*\)([^;]*$/s//\1/p;d' <$SRC`; do
    echo -n "$n: "
    echo `find . -name '*.[ch]' | fgrep -vx ./$SRC | xargs grep -lrw $n`
done

File is "out":
wc -l out
     89 out
sed 's|\./net/ipv4/[^/]*\>||g' <out | fgrep -v . | wc -l
     64
sed 's|\./net/ipv4/[^/]*\>||g' <out | grep -c net/ipv6 
22

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

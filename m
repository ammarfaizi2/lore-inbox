Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131664AbRAGNSH>; Sun, 7 Jan 2001 08:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRAGNRr>; Sun, 7 Jan 2001 08:17:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:36617 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131664AbRAGNRp>;
	Sun, 7 Jan 2001 08:17:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: richbaum@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0 
In-Reply-To: Your message of "Sun, 07 Jan 2001 07:41:57 CDT."
             <3A586415.699EFDE@yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 00:17:39 +1100
Message-ID: <310.978873459@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jan 2001 07:41:57 -0500, 
Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
>Rich Baum wrote:
>> 
>> Here's a patch that fixes more of the compile warnings with gcc
>> 2.97.
>> -#endif __SNMP__
>> +#endif /* __SNMP__ */
>
>Might as well automate it for all of these endif ones through the entire
>kernel (assuming you already haven't of course).
>
>Paul.
>  -----------------------------8<-----------8<------------------------
>#!/bin/bash
>for i in `find . -type f -name '*.[chS]'`
>do
>	grep -q '^#endif [A-Za-z0-9_]' $i 2>/dev/null
>	if [ $? == 0 ]; then
>		mv $i $i~
>		sed 's/^#endif \([A-Za-z0-9_]\+$\)/#endif \/\* \1 \*\//'<$i~>$i
>	fi
>done
>  -----------------------------8<-----------8<------------------------

#endif can have white space before '#' and between '#' and 'endif', it
can have tabs instead of spaces, the spurious text is anything that
does not start with '/'.  Time to start a new one liner contest ;) ...

find -type f -name '*.[chS]' | xargs perl -lpi -e 's:^(\s*#\s*endif)\s+([^/\s].*)$:\1\t/* \2 */:;'

It even preserves the existing #endif layout.  That regexp does not
catch #endif /foo, it assumes that '/' always starts a comment.  The
extra complexity to catch that rare case is not worth it.  The command
changed 97 files on base 2.4.0.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131585AbRAGM5K>; Sun, 7 Jan 2001 07:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131550AbRAGM5A>; Sun, 7 Jan 2001 07:57:00 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:35849 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131625AbRAGMzz>; Sun, 7 Jan 2001 07:55:55 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A586415.699EFDE@yahoo.com>
Date: Sun, 07 Jan 2001 07:41:57 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: richbaum@acm.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <3A5790E3.18256.963C79@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rich Baum wrote:
> 
> Here's a patch that fixes more of the compile warnings with gcc
> 2.97.

[...]

> -#endif __SNMP__
> +#endif /* __SNMP__ */

Might as well automate it for all of these endif ones through the entire
kernel (assuming you already haven't of course).

Paul.
  -----------------------------8<-----------8<------------------------
#!/bin/bash
for i in `find . -type f -name '*.[chS]'`
do
	grep -q '^#endif [A-Za-z0-9_]' $i 2>/dev/null
	if [ $? == 0 ]; then
		mv $i $i~
		sed 's/^#endif \([A-Za-z0-9_]\+$\)/#endif \/\* \1 \*\//'<$i~>$i
	fi
done
  -----------------------------8<-----------8<------------------------


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

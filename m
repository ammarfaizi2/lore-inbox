Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRKMWnU>; Tue, 13 Nov 2001 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279782AbRKMWnK>; Tue, 13 Nov 2001 17:43:10 -0500
Received: from quark.didntduck.org ([216.43.55.190]:3346 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S279778AbRKMWm4>; Tue, 13 Nov 2001 17:42:56 -0500
Message-ID: <3BF1A1DE.E1FF55D8@didntduck.org>
Date: Tue, 13 Nov 2001 17:42:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Per Persson <per.persson@gnosjo.pp.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] search_one_table()
In-Reply-To: <NDBBJMOHILCIIKFHCBHAIEOECAAA.per.persson@gnosjo.pp.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Persson wrote:
> 
> I found that gcc doesn't manage to do this rewrite itself. My micro-patch
> saves a few bytes. Also the code becomes a little bit cleaner (IMHO).
> 
> Probably the same change could (and should) be made for the other
> architectures too.
> 
> Per Persson
> per.persson@gnosjo.pp.se
> 
> --- arch/i386/mm/extable.c.orig Mon Nov 12 00:13:52 2001
> +++ arch/i386/mm/extable.c      Tue Nov 13 17:39:42 2001
> @@ -19,7 +19,7 @@
>                 const struct exception_table_entry *mid;
>                 long diff;
> 
> -               mid = (last - first) / 2 + first;
> +               mid = (last + first) / 2
>                 diff = mid->insn - value;
>                  if (diff == 0)
>                          return mid->fixup;
> 

This change will not work because of lost high bits due to overflow. 
Remember that kernel addresses are in the 0xc0000000-0xffffffff range.

--

				Brian Gerst

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSBSSlB>; Tue, 19 Feb 2002 13:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSBSSkv>; Tue, 19 Feb 2002 13:40:51 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52700 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286687AbSBSSkm>; Tue, 19 Feb 2002 13:40:42 -0500
Date: Tue, 19 Feb 2002 11:40:20 -0700
Message-Id: <200202191840.g1JIeKt18971@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: linux-kernel@vger.kernel.org
Reply-To: devfs@oss.sgi.com
Subject: Re: [PATCH] a little strings-aware code change
In-Reply-To: <20020219030003.D1639@zzz.zzz.zzz>
In-Reply-To: <200202180612.g1I6C4L25410@vindaloo.ras.ucalgary.ca>
	<20020219030003.D1639@zzz.zzz.zzz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Zaitsev writes:
> This little patch does nothing with the functionality of devfsd, but
> with the C code.  There are a number of constructions like:
> 
>        [PFXLEN = strlen(prefix);]
>         if (strncmp(str, prefix, PFXLEN) == 0)
>                 do_something_with(str + PFXLEN);
> 
> It is not the best way to do such a things.  The idea is to implement
> the special function, which will test the string for some prefix and
> return the address of a place of the string after that prefix or NULL
> in case of an absence of the success.  The construction above becomes
> better:
> 
>         if (ptr= strtry(str, prefix))
>                 do_something_with(ptr);
> 
> And the new function itself is more lightweight than alone strncmp,
> and just much more effective than <strlen + strncmp> in a couple.  It
> is good again.  So, all the idea seems to be healthy.  I call this
> function "strtry", as it tries its arg for the given prefix.

Apart from not really liking this approach, you've made the strtry()
function inlined. Any saving you might make with removing code from
the callers is probably more than lost due to all the extra inlined
code.

Did you compare the sizes of the stripped binary to see what the
effect of your patch is?

> Richard, please, apply this patch, if you find it useful.  It is
> against devfsd-1.3.22.  By the way, I've arranged the
>         strrchr (devname, '/') + 1
> stuff, so this thing to be done once instead of multiply times in the
> original.

But you've inserted calls to strrchr in cases where it's not really
needed.

BTW: linux-kernel isn't the right place to discuss devfsd
development. The right place is devfs@oss.sgi.com (I've set Reply-To:
to do this).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

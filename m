Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRJ1Gj2>; Sun, 28 Oct 2001 01:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277729AbRJ1GjH>; Sun, 28 Oct 2001 01:39:07 -0500
Received: from smi-105.smith.uml.edu ([129.63.206.105]:14341 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S277728AbRJ1GjE>;
	Sun, 28 Oct 2001 01:39:04 -0500
Date: Sun, 28 Oct 2001 01:39:39 -0500
From: Alex Pennace <alex@pennace.org>
To: Amit Kucheria <amitk@ittc.ku.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using objdump to debug some n/w code in kernel
Message-ID: <20011028013939.C26005@buick.pennace.org>
Mail-Followup-To: Amit Kucheria <amitk@ittc.ku.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110280124540.16994-100000@havoc.ittc.ku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110280124540.16994-100000@havoc.ittc.ku.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 01:25:06AM -0500, Amit Kucheria wrote:
> I am using the 'makelst' script in the scripts directory to generate
> interleaved source code and assembly listing. This script uses 'objdump'
> 
> Now my problem is that the original C code and the .lst files dont seem to
> match. They are listed below.
[...]
> Can anybody throw any light on this 'phenomena' ?
> BTW, the string ': "memory");' seems to be repeating in a lot of
> places in the .lst file. Is there something about objdump that i havent
> read up on.
> 
> Regards,
> Amit
> 
> Original code:
> -------------
> /* .......
>    So host > network > gateway entries.
> */
>     for (i=0; i < MAX_ROUTING_ENTRIES; i++)
>     {
>         /* copy the routing entry into our local variable..just to be safe
>            We will optimize later by doing without this copy */
>         memcpy(&tmp_entry, ptr_route, sizeof(struct routing_entry));
> 
>         switch(tmp_entry.rt_flag)
>         {
>             case 'H':
>                 /* if dest ip is a host entry */
> ----- end original code -----------------
> 
> Code generated using 'makelst:
> -------------------------------
> /* ....
>    So host > network > gateway entries.
> */
>     for (i=0; i < MAX_ROUTING_ENTRIES; i++)
> c01b3206:       31 ed                   xor    %ebp,%ebp
> c01b3208:       8d 5c 24 48             lea    0x48(%esp,1),%ebx
> c01b320c:       8d 54 24 68             lea    0x68(%esp,1),%edx
> c01b3210:       8b 49 5c                mov    0x5c(%ecx),%ecx
> c01b3213:       89 4c 24 18             mov    %ecx,0x18(%esp,1)
> c01b3217:       89 54 24 10             mov    %edx,0x10(%esp,1)
> c01b321b:       8d 4c 24 28             lea    0x28(%esp,1),%ecx
> c01b321f:       89 4c 24 14             mov    %ecx,0x14(%esp,1)
> c01b3223:       90                      nop
>         : "memory");
> {
>         int d0, d1, d2;
>         switch (n % 4) {
>                 case 0: COMMON(""); return to;
[...]

memcpy is a macro. See linux/include/asm-i386/string.h.

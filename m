Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277727AbRJ1GZN>; Sun, 28 Oct 2001 01:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277728AbRJ1GZE>; Sun, 28 Oct 2001 01:25:04 -0500
Received: from stephens.ittc.ku.edu ([129.237.125.220]:39555 "EHLO
	stephens.ittc.ku.edu") by vger.kernel.org with ESMTP
	id <S277727AbRJ1GYx>; Sun, 28 Oct 2001 01:24:53 -0500
Date: Sun, 28 Oct 2001 01:25:28 -0500 (CDT)
From: Amit Kucheria <amitk@ittc.ku.edu>
To: <linux-kernel@vger.kernel.org>
Subject: using objdump to debug some n/w code in kernel
Message-ID: <Pine.LNX.4.33.0110280124540.16994-100000@havoc.ittc.ku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using the 'makelst' script in the scripts directory to generate
interleaved source code and assembly listing. This script uses 'objdump'

Now my problem is that the original C code and the .lst files dont seem to
match. They are listed below.

I get an oops with EIP at c01b3230. But the corresponding C code for that
(switch (n % 4)) isnt written by me!! In other words the instructions
between c01b3223 - c01b3232 dont seem to make sense.

Can anybody throw any light on this 'phenomena' ?
BTW, the string ': "memory");' seems to be repeating in a lot of
places in the .lst file. Is there something about objdump that i havent
read up on.

Regards,
Amit

Original code:
-------------
/* .......
   So host > network > gateway entries.
*/
    for (i=0; i < MAX_ROUTING_ENTRIES; i++)
    {
        /* copy the routing entry into our local variable..just to be safe
           We will optimize later by doing without this copy */
        memcpy(&tmp_entry, ptr_route, sizeof(struct routing_entry));

        switch(tmp_entry.rt_flag)
        {
            case 'H':
                /* if dest ip is a host entry */
----- end original code -----------------

Code generated using 'makelst:
-------------------------------
/* ....
   So host > network > gateway entries.
*/
    for (i=0; i < MAX_ROUTING_ENTRIES; i++)
c01b3206:       31 ed                   xor    %ebp,%ebp
c01b3208:       8d 5c 24 48             lea    0x48(%esp,1),%ebx
c01b320c:       8d 54 24 68             lea    0x68(%esp,1),%edx
c01b3210:       8b 49 5c                mov    0x5c(%ecx),%ecx
c01b3213:       89 4c 24 18             mov    %ecx,0x18(%esp,1)
c01b3217:       89 54 24 10             mov    %edx,0x10(%esp,1)
c01b321b:       8d 4c 24 28             lea    0x28(%esp,1),%ecx
c01b321f:       89 4c 24 14             mov    %ecx,0x14(%esp,1)
c01b3223:       90                      nop
        : "memory");
{
        int d0, d1, d2;
        switch (n % 4) {
                case 0: COMMON(""); return to;
c01b3224:       b9 08 00 00 00          mov    $0x8,%ecx
c01b3229:       89 df                   mov    %ebx,%edi
c01b322b:       8b 74 24 18             mov    0x18(%esp,1),%esi
c01b322f:       fc                      cld
c01b3230:       f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
    {
        /* copy the routing entry into our local variable..just to be safe
We will optimize later by doing without this copy */
        memcpy(&tmp_entry, ptr_route, sizeof(struct routing_entry));

        switch(tmp_entry.rt_flag)
c01b3232:       8a 44 24 54             mov    0x54(%esp,1),%al
c01b3236:       3c 48                   cmp    $0x48,%al
c01b3238:       74 1a                   je     c01b3254
<veth_route_lookup+0xa8>c01b323a:       7f 0c                   jg
c01b3248 <veth_route_lookup+0x9c>c01b323c:       3c 47
cmp    $0x47,%al
c01b323e:       74 60                   je     c01b32a0
<veth_route_lookup+0xf4>c01b3240:       e9 d9 00 00 00          jmp
c01b331e <veth_route_lookup+0x172>
c01b3245:       8d 76 00                lea    0x0(%esi),%esi
c01b3248:       3c 4e                   cmp    $0x4e,%al
c01b324a:       74 54                   je     c01b32a0
<veth_route_lookup+0xf4>c01b324c:       e9 cd 00 00 00          jmp
c01b331e <veth_route_lookup+0x172>
c01b3251:       8d 76 00                lea    0x0(%esi),%esi
        {
            case 'H':
                /* if dest ip is a host entry */
 ------- end of makelst code ----------------

-- 
^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^
                  Amit Kucheria
          EECS Grad. Research Assistant
         University of Kansas @ Lawrence
   (R)+1-(785)-830 8521 ||| (O)+1-(785)-864 7774
____________________________________________________




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129733AbQKWRf3>; Thu, 23 Nov 2000 12:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129732AbQKWRfT>; Thu, 23 Nov 2000 12:35:19 -0500
Received: from 17-VALL-X8.libre.retevision.es ([62.83.212.17]:1664 "EHLO
        looping.es") by vger.kernel.org with ESMTP id <S129731AbQKWRfM>;
        Thu, 23 Nov 2000 12:35:12 -0500
Date: Thu, 23 Nov 2000 17:58:49 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: {PATCH} isofs stuff
Message-ID: <20001123175849.A116@macula.net>
In-Reply-To: <UTC200011230350.EAA138908.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <UTC200011230350.EAA138908.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Nov 23, 2000 at 04:50:22AM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 04:50:22AM +0100, Andries.Brouwer@cwi.nl wrote:
> Below a working patch for which the isofs images I got
> all are OK. (There is still a lot of silliness here -
> superfluous parentheses, a rename of isofs_cmp to isofs_comp
> in one file to avoid confusion with the isofs_cmp in another file..)

Yup, indeed it solves the dir/namei problem.  

However, while my ide drive is fine, my mistumi (mcdx) still oopses and/or
aaies when doing dd on it.  Here's what I was able to catch from the trace..
doesn't look too relevant, tho.  I tried oopisng it again, but it spew a
list of hex addresses as long as my arm and couldn't catch the first one. 

__wake_up  ce-28
0xe3c9d34d
handle_scancode
del_timer
handle_scancode
do_SAK
vc_resize

Where  __wake_up:

c0113f95:       89 15 4c 01 22 c0       movl   %edx,0xc022014c
c0113f9b:       ff 05 44 c4 25 c0       incl   0xc025c444
c0113fa1:       89 d8                   movl   %ebx,%eax
c0113fa3:       e8 10 fa ff ff          call   c01139b8 <reschedule_idle>
c0113fa8:       57                      pushl  %edi
c0113fa9:       9d                      popf   
c0113faa:       8b 4d f8                movl   0xfffffff8(%ebp),%ecx
c0113fad:       23 4e 00                andl   0x0(%esi),%ecx
c0113fb0:       f6 c1 01                testb  $0x1,%cl
c0113fb3:       75 43                   jne    c0113ff8 <__wake_up+0xd0>
c0113fb5:       8b 45 e8                movl   0xffffffe8(%ebp),%eax
c0113fb8:       39 45 e4                cmpl   %eax,0xffffffe4(%ebp)
c0113fbb:       74 3b                   je     c0113ff8 <__wake_up+0xd0>
c0113fbd:       8b 75 e4                movl   0xffffffe4(%ebp),%esi
c0113fc0:       8b 55 e4                movl   0xffffffe4(%ebp),%edx
c0113fc3:       83 c6 f8                addl   $0xfffffff8,%esi
c0113fc6:       8b 12                   movl   (%edx),%edx
c0113fc8:       89 55 e4                movl   %edx,0xffffffe4(%ebp)
c0113fcb:       8b 5e 04                movl   0x4(%esi),%ebx

>>> c0113fce:   8b 03                   movl   (%ebx),%eax

c0113fd0:       85 45 fc                testl  %eax,0xfffffffc(%ebp)
c0113fd3:       74 e0                   je     c0113fb5 <__wake_up+0x8d>
c0113fd5:       83 7d f4 00             cmpl   $0x0,0xfffffff4(%ebp)
c0113fd9:       74 96                   je     c0113f71 <__wake_up+0x49>
c0113fdb:       8b 4d f8                movl   0xfffffff8(%ebp),%ecx
c0113fde:       23 4e 00                andl   0x0(%esi),%ecx

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

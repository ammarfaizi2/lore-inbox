Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270347AbRHWU4x>; Thu, 23 Aug 2001 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270339AbRHWU4e>; Thu, 23 Aug 2001 16:56:34 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:47597 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S270299AbRHWU41>; Thu, 23 Aug 2001 16:56:27 -0400
Message-ID: <3B856E09.EAAE6564@pandora.be>
Date: Thu, 23 Aug 2001 22:56:41 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: assembler -> linux system calls
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to write a linux device driver for a data acquisition
card.  The little homepage for my project is at
http://mc303.ulyssis.org/heim/
There is already a DOS driver available, and I am trying to port the
DOS code right now.

Somewhere in the DOS code, there is some assembler code included:

.RADIX 16
.MODEL SMALL

.486


.CODE

      PUBLIC _inpl

_inpl PROC FAR

      push   bp
      mov    bp,sp

      mov    dx, Word Ptr [bp+6]
      in     EAX,dx

;     bswap  EAX

      push   EAX
      pop    ax
      pop    dx

      mov    sp,bp
      pop    bp
      ret
_inpl ENDP


      PUBLIC _inplI

_inplI PROC FAR

      push   bp
      mov    bp,sp

      mov    dx, Word Ptr [bp+6]
      in     EAX,dx

      push   EAX
      pop    ax
      pop    dx

      mov    sp,bp
      pop    bp
      ret
_inplI ENDP



      PUBLIC _swem

_swem PROC FAR

      push   bp
      mov    bp,sp

      mov    EAX, DWord Ptr [bp+6]

      bswap  EAX

      push   EAX
      pop    ax
      pop    dx

      mov    sp,bp
      pop    bp
      ret
_swem ENDP


      PUBLIC _outpl

_outpl PROC FAR

      push   bp
      mov    bp,sp

      mov    dx, Word Ptr [bp+0ah]
      mov    ax, Word Ptr [bp+8]
      push   ax
      push   dx
      pop    EAX
      mov    dx, Word Ptr [bp+6]
      out    dx,EAX

      mov    sp,bp
      pop    bp
      ret
_outpl ENDP


      PUBLIC _outplI

_outplI PROC FAR

      push   bp
      mov    bp,sp

      mov    dx, Word Ptr [bp+8]
      mov    ax, Word Ptr [bp+0ah]
      push   ax
      push   dx
      pop    EAX
      mov    dx, Word Ptr [bp+6]
      out    dx,EAX

      mov    sp,bp
      pop    bp
      ret
_outplI ENDP

      END


I would like to know by what linux native system calls I can replace
the commands inpl, inplI, outpl, outplI, swem.  I guess the following
mapping should do it:

DOS assembler	-> 	Linux

inpl			inpl
inplI			???
outpl			outpl
outplI			???
swem			???


Could somebody tell me what function to use where the question marks
are written?  Are the other mappings from inpl and outpl also correct?

Thanks for helping me out,
mc303

PS: The DOS code is also at http://mc303.ulyssis.org/heim

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
